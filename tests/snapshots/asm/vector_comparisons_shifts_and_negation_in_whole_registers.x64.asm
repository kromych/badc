
vector_comparisons_shifts_and_negation_in_whole_registers.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x118, %rsp            # imm = 0x118
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	leaq	-0x110(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x100(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	-0x100(%rbp), %xmm0
               	movups	-0x110(%rbp), %xmm1
               	vpcmpgtb	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, -0xf0(%rbp)
               	leaq	-0xb0(%rbp), %rcx
               	xorl	%eax, %eax
               	movl	$0xffffff, -0xb0(%rbp)  # imm = 0xFFFFFF
               	movl	$0xffff00, -0xac(%rbp)  # imm = 0xFFFF00
               	movl	$0xff0000ff, -0xa8(%rbp) # imm = 0xFF0000FF
               	movl	$0xffffffff, -0xa4(%rbp) # imm = 0xFFFFFFFF
               	leaq	-0xe0(%rbp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	-0x110(%rbp), %xmm0
               	movups	-0x100(%rbp), %xmm1
               	vpcmpgtb	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, -0xd0(%rbp)
               	leaq	-0xb0(%rbp), %rsi
               	movl	$0xffff0000, -0xb0(%rbp) # imm = 0xFFFF0000
               	movl	$0xff00ffff, -0xac(%rbp) # imm = 0xFF00FFFF
               	xorl	%ecx, %ecx
               	movl	$0xffffff, -0xa8(%rbp)  # imm = 0xFFFFFF
               	movq	$-0x1, %rdx
               	movl	$0xff0000, -0xa4(%rbp)  # imm = 0xFF0000
               	leaq	-0xc0(%rbp), %rdi
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	-0x110(%rbp), %rsi
               	leaq	-0x100(%rbp), %rdi
               	movups	-0x110(%rbp), %xmm0
               	movups	-0x100(%rbp), %xmm1
               	vpcmpeqb	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, -0xb0(%rbp)
               	leaq	-0xf0(%rbp), %r8
               	movsbq	(%r8,%rax), %r8
               	movsbq	(%rdi,%rax), %r9
               	movsbq	(%rsi,%rax), %rbx
               	cmpl	%r9d, %ebx
               	movq	%rcx, %r9
               	cmovlq	%rdx, %r9
               	cmpl	%r9d, %r8d
               	jne	<addr>
               	leaq	-0xe0(%rbp), %r8
               	movsbq	(%r8,%rax), %r8
               	leaq	-0x110(%rbp), %r9
               	leaq	-0x100(%rbp), %rbx
               	movsbq	(%rbx,%rax), %rbx
               	movq	$-0x1, %r12
               	xorl	%r13d, %r13d
               	movsbq	(%r9,%rax), %r9
               	cmpl	%ebx, %r9d
               	cmovgq	%r13, %r12
               	cmpl	%r12d, %r8d
               	jne	<addr>
               	leaq	-0xd0(%rbp), %r8
               	movsbq	(%r8,%rax), %r8
               	leaq	-0x110(%rbp), %r9
               	leaq	-0x100(%rbp), %rbx
               	movsbq	(%rbx,%rax), %rbx
               	movq	$-0x1, %r12
               	xorl	%r13d, %r13d
               	movsbq	(%r9,%rax), %r9
               	cmpl	%ebx, %r9d
               	cmovleq	%r13, %r12
               	cmpl	%r12d, %r8d
               	jne	<addr>
               	leaq	-0xc0(%rbp), %r8
               	movsbq	(%r8,%rax), %r8
               	leaq	-0x110(%rbp), %r9
               	leaq	-0x100(%rbp), %rbx
               	movsbq	(%rbx,%rax), %rbx
               	movq	$-0x1, %r12
               	xorl	%r13d, %r13d
               	movsbq	(%r9,%rax), %r9
               	cmpl	%ebx, %r9d
               	cmovlq	%r13, %r12
               	cmpl	%r12d, %r8d
               	jne	<addr>
               	leaq	-0xb0(%rbp), %r8
               	movsbq	(%r8,%rax), %r8
               	leaq	-0x110(%rbp), %r9
               	leaq	-0x100(%rbp), %rbx
               	movsbq	(%rbx,%rax), %rbx
               	movq	$-0x1, %r12
               	xorl	%r13d, %r13d
               	movsbq	(%r9,%rax), %r9
               	cmpl	%ebx, %r9d
               	cmovneq	%r13, %r12
               	cmpl	%r12d, %r8d
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x110(%rbp), %rax
               	leaq	-0xa0(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x100(%rbp), %rax
               	leaq	-0x90(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0xb0(%rbp), %rcx
               	xorl	%eax, %eax
               	movl	$0xff000000, -0xb0(%rbp) # imm = 0xFF000000
               	movl	$0xff0000ff, -0xac(%rbp) # imm = 0xFF0000FF
               	movl	$0xff000000, -0xa8(%rbp) # imm = 0xFF000000
               	movl	$0xff00ffff, -0xa4(%rbp) # imm = 0xFF00FFFF
               	leaq	-0xf0(%rbp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	-0xb0(%rbp), %rcx
               	movl	$0xffff0000, -0xb0(%rbp) # imm = 0xFFFF0000
               	movl	$0xff00ffff, -0xac(%rbp) # imm = 0xFF00FFFF
               	movl	$0xff0000ff, -0xa8(%rbp) # imm = 0xFF0000FF
               	movl	$0xffffffff, -0xa4(%rbp) # imm = 0xFFFFFFFF
               	leaq	-0xe0(%rbp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	-0xb0(%rbp), %rcx
               	movl	$0xffff, -0xb0(%rbp)    # imm = 0xFFFF
               	movl	$0xff0000, -0xac(%rbp)  # imm = 0xFF0000
               	movl	$0xffff00, -0xa8(%rbp)  # imm = 0xFFFF00
               	movl	$0x0, -0xa4(%rbp)
               	leaq	-0xd0(%rbp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	-0xb0(%rbp), %rsi
               	movl	$0xffffff, -0xb0(%rbp)  # imm = 0xFFFFFF
               	movl	$0xffff00, -0xac(%rbp)  # imm = 0xFFFF00
               	movl	$0xffffff, -0xa8(%rbp)  # imm = 0xFFFFFF
               	xorl	%ecx, %ecx
               	movq	$-0x1, %rdx
               	movl	$0xff0000, -0xa4(%rbp)  # imm = 0xFF0000
               	leaq	-0xc0(%rbp), %rdi
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	-0xa0(%rbp), %rsi
               	leaq	-0x90(%rbp), %rdi
               	movups	-0xa0(%rbp), %xmm0
               	movups	-0x90(%rbp), %xmm1
               	vpcmpeqb	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, -0xb0(%rbp)
               	leaq	-0xf0(%rbp), %r8
               	movsbq	(%r8,%rax), %r8
               	movzbq	(%rdi,%rax), %r9
               	movzbq	(%rsi,%rax), %rbx
               	cmpl	%r9d, %ebx
               	movq	%rcx, %r9
               	cmovlq	%rdx, %r9
               	cmpl	%r9d, %r8d
               	jne	<addr>
               	leaq	-0xe0(%rbp), %r8
               	movsbq	(%r8,%rax), %r8
               	leaq	-0xa0(%rbp), %r9
               	leaq	-0x90(%rbp), %rbx
               	movzbq	(%rbx,%rax), %rbx
               	movq	$-0x1, %r12
               	xorl	%r13d, %r13d
               	movzbq	(%r9,%rax), %r9
               	cmpl	%ebx, %r9d
               	cmovgq	%r13, %r12
               	cmpl	%r12d, %r8d
               	jne	<addr>
               	leaq	-0xd0(%rbp), %r8
               	movsbq	(%r8,%rax), %r8
               	leaq	-0xa0(%rbp), %r9
               	leaq	-0x90(%rbp), %rbx
               	movzbq	(%rbx,%rax), %rbx
               	movq	$-0x1, %r12
               	xorl	%r13d, %r13d
               	movzbq	(%r9,%rax), %r9
               	cmpl	%ebx, %r9d
               	cmovleq	%r13, %r12
               	cmpl	%r12d, %r8d
               	jne	<addr>
               	leaq	-0xc0(%rbp), %r8
               	movsbq	(%r8,%rax), %r8
               	leaq	-0xa0(%rbp), %r9
               	leaq	-0x90(%rbp), %rbx
               	movzbq	(%rbx,%rax), %rbx
               	movq	$-0x1, %r12
               	xorl	%r13d, %r13d
               	movzbq	(%r9,%rax), %r9
               	cmpl	%ebx, %r9d
               	cmovlq	%r13, %r12
               	cmpl	%r12d, %r8d
               	jne	<addr>
               	leaq	-0xb0(%rbp), %r8
               	movsbq	(%r8,%rax), %r8
               	leaq	-0xa0(%rbp), %r9
               	leaq	-0x90(%rbp), %rbx
               	movzbq	(%rbx,%rax), %rbx
               	movq	$-0x1, %r12
               	xorl	%r13d, %r13d
               	movzbq	(%r9,%rax), %r9
               	cmpl	%ebx, %r9d
               	cmovneq	%r13, %r12
               	cmpl	%r12d, %r8d
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x48(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	leaq	-0x40(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movsd	-0x40(%rbp), %xmm0
               	movsd	-0x48(%rbp), %xmm1
               	vpcmpgtw	%xmm1, %xmm0, %xmm2
               	movsd	%xmm2, -0x28(%rbp)
               	xorl	%eax, %eax
               	movl	$0xffffffff, %ecx       # imm = 0xFFFFFFFF
               	movq	%rcx, -0x20(%rbp)
               	vpcmpgtw	%xmm0, %xmm1, %xmm0
               	movsd	%xmm0, -0x18(%rbp)
               	xorl	%edx, %edx
               	movq	$-0x10000, -0x10(%rbp)  # imm = 0xFFFF0000
               	leaq	-0x48(%rbp), %rcx
               	leaq	-0x40(%rbp), %rsi
               	movsd	-0x48(%rbp), %xmm0
               	movsd	-0x40(%rbp), %xmm1
               	vpcmpeqw	%xmm1, %xmm0, %xmm0
               	movsd	%xmm0, -0x8(%rbp)
               	leaq	-0x28(%rbp), %rdi
               	movswq	(%rdi,%rax,2), %rdi
               	movswq	(%rsi,%rax,2), %r8
               	movq	$-0x1, %r9
               	movswq	(%rcx,%rax,2), %rbx
               	cmpl	%r8d, %ebx
               	cmovgeq	%rdx, %r9
               	cmpl	%r9d, %edi
               	jne	<addr>
               	leaq	-0x20(%rbp), %rdi
               	movswq	(%rdi,%rax,2), %rdi
               	leaq	-0x40(%rbp), %r8
               	movswq	(%r8,%rax,2), %r8
               	movq	$-0x1, %r9
               	xorl	%ebx, %ebx
               	movswq	(%rcx,%rax,2), %r12
               	cmpl	%r8d, %r12d
               	cmovgq	%rbx, %r9
               	cmpl	%r9d, %edi
               	jne	<addr>
               	leaq	-0x18(%rbp), %rdi
               	movswq	(%rdi,%rax,2), %rdi
               	leaq	-0x48(%rbp), %r8
               	leaq	-0x40(%rbp), %r9
               	movswq	(%r9,%rax,2), %r9
               	movq	$-0x1, %rbx
               	xorl	%r12d, %r12d
               	movswq	(%r8,%rax,2), %r8
               	cmpl	%r9d, %r8d
               	cmovleq	%r12, %rbx
               	cmpl	%ebx, %edi
               	jne	<addr>
               	leaq	-0x10(%rbp), %rdi
               	movswq	(%rdi,%rax,2), %rdi
               	leaq	-0x48(%rbp), %r8
               	leaq	-0x40(%rbp), %r9
               	movswq	(%r9,%rax,2), %r9
               	movq	$-0x1, %rbx
               	xorl	%r12d, %r12d
               	movswq	(%r8,%rax,2), %r8
               	cmpl	%r9d, %r8d
               	cmovlq	%r12, %rbx
               	cmpl	%ebx, %edi
               	jne	<addr>
               	leaq	-0x8(%rbp), %rdi
               	movswq	(%rdi,%rax,2), %rdi
               	leaq	-0x48(%rbp), %r8
               	leaq	-0x40(%rbp), %r9
               	movswq	(%r9,%rax,2), %r9
               	movq	$-0x1, %rbx
               	xorl	%r12d, %r12d
               	movswq	(%r8,%rax,2), %r8
               	cmpl	%r9d, %r8d
               	cmovneq	%r12, %rbx
               	cmpl	%ebx, %edi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x48(%rbp), %rax
               	leaq	-0x38(%rbp), %rcx
               	movq	(%rax), %r10
               	movq	%r10, (%rcx)
               	leaq	-0x40(%rbp), %rax
               	leaq	-0x30(%rbp), %rcx
               	movq	(%rax), %r10
               	movq	%r10, (%rcx)
               	xorl	%eax, %eax
               	movabsq	$0xffff00000000, %rcx   # imm = 0xFFFF00000000
               	movq	%rcx, -0x28(%rbp)
               	movabsq	$0xffffffff0000, %rcx   # imm = 0xFFFFFFFF0000
               	movq	%rcx, -0x20(%rbp)
               	movabsq	$-0xffffffff0001, %rcx  # imm = 0xFFFF00000000FFFF
               	movq	%rcx, -0x18(%rbp)
               	movabsq	$-0xffff00000001, %rcx  # imm = 0xFFFF0000FFFFFFFF
               	movq	%rcx, -0x10(%rbp)
               	leaq	-0x38(%rbp), %rcx
               	leaq	-0x30(%rbp), %rdx
               	movsd	-0x38(%rbp), %xmm0
               	movsd	-0x30(%rbp), %xmm1
               	vpcmpeqw	%xmm1, %xmm0, %xmm0
               	movsd	%xmm0, -0x8(%rbp)
               	leaq	-0x28(%rbp), %rsi
               	movswq	(%rsi,%rax,2), %rsi
               	movzwq	(%rdx,%rax,2), %rdi
               	movq	$-0x1, %r8
               	xorl	%r9d, %r9d
               	movzwq	(%rcx,%rax,2), %rbx
               	cmpl	%edi, %ebx
               	cmovgeq	%r9, %r8
               	cmpl	%r8d, %esi
               	jne	<addr>
               	leaq	-0x20(%rbp), %rsi
               	movswq	(%rsi,%rax,2), %rsi
               	movzwq	(%rdx,%rax,2), %rdi
               	movq	$-0x1, %r8
               	xorl	%r9d, %r9d
               	movzwq	(%rcx,%rax,2), %rbx
               	cmpl	%edi, %ebx
               	cmovgq	%r9, %r8
               	cmpl	%r8d, %esi
               	jne	<addr>
               	leaq	-0x18(%rbp), %rsi
               	movswq	(%rsi,%rax,2), %rsi
               	leaq	-0x38(%rbp), %rdi
               	leaq	-0x30(%rbp), %r8
               	movzwq	(%r8,%rax,2), %r8
               	movq	$-0x1, %r9
               	xorl	%ebx, %ebx
               	movzwq	(%rdi,%rax,2), %rdi
               	cmpl	%r8d, %edi
               	cmovleq	%rbx, %r9
               	cmpl	%r9d, %esi
               	jne	<addr>
               	leaq	-0x10(%rbp), %rsi
               	movswq	(%rsi,%rax,2), %rsi
               	leaq	-0x38(%rbp), %rdi
               	leaq	-0x30(%rbp), %r8
               	movzwq	(%r8,%rax,2), %r8
               	movq	$-0x1, %r9
               	xorl	%ebx, %ebx
               	movzwq	(%rdi,%rax,2), %rdi
               	cmpl	%r8d, %edi
               	cmovlq	%rbx, %r9
               	cmpl	%r9d, %esi
               	jne	<addr>
               	leaq	-0x8(%rbp), %rsi
               	movswq	(%rsi,%rax,2), %rsi
               	leaq	-0x38(%rbp), %rdi
               	leaq	-0x30(%rbp), %r8
               	movzwq	(%r8,%rax,2), %r8
               	movq	$-0x1, %r9
               	xorl	%ebx, %ebx
               	movzwq	(%rdi,%rax,2), %rdi
               	cmpl	%r8d, %edi
               	cmovneq	%rbx, %r9
               	cmpl	%r9d, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x80(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x70(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	-0x70(%rbp), %xmm1
               	movups	-0x80(%rbp), %xmm0
               	vpcmpgtd	%xmm0, %xmm1, %xmm1
               	movups	%xmm1, -0xf0(%rbp)
               	xorl	%eax, %eax
               	movl	$0xffffffff, %ecx       # imm = 0xFFFFFFFF
               	movq	%rcx, -0xe0(%rbp)
               	movq	$-0x1, -0xd8(%rbp)
               	movups	-0x70(%rbp), %xmm1
               	vpcmpgtd	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, -0xd0(%rbp)
               	xorl	%edx, %edx
               	movabsq	$-0x100000000, %rcx     # imm = 0xFFFFFFFF00000000
               	movq	%rcx, -0xc0(%rbp)
               	movq	$-0x1, -0xb8(%rbp)
               	leaq	-0x80(%rbp), %rcx
               	leaq	-0x70(%rbp), %rsi
               	movups	-0x80(%rbp), %xmm0
               	vpcmpeqd	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, -0xb0(%rbp)
               	leaq	-0xf0(%rbp), %rdi
               	movl	(%rdi,%rax,4), %edi
               	movl	(%rsi,%rax,4), %r8d
               	movq	$-0x1, %r9
               	movl	(%rcx,%rax,4), %ebx
               	cmpl	%r8d, %ebx
               	cmovgeq	%rdx, %r9
               	cmpl	%r9d, %edi
               	jne	<addr>
               	leaq	-0xe0(%rbp), %rdi
               	movl	(%rdi,%rax,4), %edi
               	leaq	-0x70(%rbp), %r8
               	movl	(%r8,%rax,4), %r8d
               	movq	$-0x1, %r9
               	xorl	%ebx, %ebx
               	movl	(%rcx,%rax,4), %r12d
               	cmpl	%r8d, %r12d
               	cmovgq	%rbx, %r9
               	cmpl	%r9d, %edi
               	jne	<addr>
               	leaq	-0xd0(%rbp), %rdi
               	movl	(%rdi,%rax,4), %edi
               	leaq	-0x80(%rbp), %r8
               	leaq	-0x70(%rbp), %r9
               	movl	(%r9,%rax,4), %r9d
               	movq	$-0x1, %rbx
               	xorl	%r12d, %r12d
               	movl	(%r8,%rax,4), %r8d
               	cmpl	%r9d, %r8d
               	cmovleq	%r12, %rbx
               	cmpl	%ebx, %edi
               	jne	<addr>
               	leaq	-0xc0(%rbp), %rdi
               	movl	(%rdi,%rax,4), %edi
               	leaq	-0x80(%rbp), %r8
               	leaq	-0x70(%rbp), %r9
               	movl	(%r9,%rax,4), %r9d
               	movq	$-0x1, %rbx
               	xorl	%r12d, %r12d
               	movl	(%r8,%rax,4), %r8d
               	cmpl	%r9d, %r8d
               	cmovlq	%r12, %rbx
               	cmpl	%ebx, %edi
               	jne	<addr>
               	leaq	-0xb0(%rbp), %rdi
               	movl	(%rdi,%rax,4), %edi
               	leaq	-0x80(%rbp), %r8
               	leaq	-0x70(%rbp), %r9
               	movl	(%r9,%rax,4), %r9d
               	movq	$-0x1, %rbx
               	xorl	%r12d, %r12d
               	movl	(%r8,%rax,4), %r8d
               	cmpl	%r9d, %r8d
               	cmovneq	%r12, %rbx
               	cmpl	%ebx, %edi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x80(%rbp), %rax
               	leaq	-0x100(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x70(%rbp), %rax
               	leaq	-0x90(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	xorl	%eax, %eax
               	movabsq	$-0x100000000, %rcx     # imm = 0xFFFFFFFF00000000
               	movq	%rcx, -0xf0(%rbp)
               	movq	$0x0, -0xe8(%rbp)
               	movq	%rcx, -0xe0(%rbp)
               	movq	$-0x1, -0xd8(%rbp)
               	movl	$0xffffffff, %ecx       # imm = 0xFFFFFFFF
               	movq	%rcx, -0xd0(%rbp)
               	movq	$0x0, -0xc8(%rbp)
               	movq	%rcx, -0xc0(%rbp)
               	movq	$-0x1, -0xb8(%rbp)
               	leaq	-0x100(%rbp), %rcx
               	leaq	-0x90(%rbp), %rdx
               	movups	-0x100(%rbp), %xmm0
               	movups	-0x90(%rbp), %xmm1
               	vpcmpeqd	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, -0xb0(%rbp)
               	leaq	-0xf0(%rbp), %rsi
               	movl	(%rsi,%rax,4), %esi
               	movl	(%rdx,%rax,4), %edi
               	movq	$-0x1, %r8
               	xorl	%r9d, %r9d
               	movl	(%rcx,%rax,4), %ebx
               	cmpl	%edi, %ebx
               	cmovaeq	%r9, %r8
               	cmpl	%r8d, %esi
               	jne	<addr>
               	leaq	-0xe0(%rbp), %rsi
               	movl	(%rsi,%rax,4), %esi
               	movl	(%rdx,%rax,4), %edi
               	movq	$-0x1, %r8
               	xorl	%r9d, %r9d
               	movl	(%rcx,%rax,4), %ebx
               	cmpl	%edi, %ebx
               	cmovaq	%r9, %r8
               	cmpl	%r8d, %esi
               	jne	<addr>
               	leaq	-0xd0(%rbp), %rsi
               	movl	(%rsi,%rax,4), %esi
               	leaq	-0x100(%rbp), %rdi
               	leaq	-0x90(%rbp), %r8
               	movl	(%r8,%rax,4), %r8d
               	movq	$-0x1, %r9
               	xorl	%ebx, %ebx
               	movl	(%rdi,%rax,4), %edi
               	cmpl	%r8d, %edi
               	cmovbeq	%rbx, %r9
               	cmpl	%r9d, %esi
               	jne	<addr>
               	leaq	-0xc0(%rbp), %rsi
               	movl	(%rsi,%rax,4), %esi
               	leaq	-0x100(%rbp), %rdi
               	leaq	-0x90(%rbp), %r8
               	movl	(%r8,%rax,4), %r8d
               	movq	$-0x1, %r9
               	xorl	%ebx, %ebx
               	movl	(%rdi,%rax,4), %edi
               	cmpl	%r8d, %edi
               	cmovbq	%rbx, %r9
               	cmpl	%r9d, %esi
               	jne	<addr>
               	leaq	-0xb0(%rbp), %rsi
               	movl	(%rsi,%rax,4), %esi
               	leaq	-0x100(%rbp), %rdi
               	leaq	-0x90(%rbp), %r8
               	movl	(%r8,%rax,4), %r8d
               	movq	$-0x1, %r9
               	xorl	%ebx, %ebx
               	movl	(%rdi,%rax,4), %edi
               	cmpl	%r8d, %edi
               	cmovneq	%rbx, %r9
               	cmpl	%r9d, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x60(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x70(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	-0x70(%rbp), %xmm1
               	movups	-0x60(%rbp), %xmm0
               	vpcmpgtq	%xmm0, %xmm1, %xmm1
               	movups	%xmm1, -0xf0(%rbp)
               	xorl	%eax, %eax
               	movq	$-0x1, -0xe0(%rbp)
               	movq	$-0x1, -0xd8(%rbp)
               	movups	-0x70(%rbp), %xmm1
               	vpcmpgtq	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, -0xd0(%rbp)
               	movq	%rax, -0xc0(%rbp)
               	movq	$-0x1, -0xb8(%rbp)
               	leaq	-0x60(%rbp), %rcx
               	leaq	-0x70(%rbp), %rdx
               	movups	-0x60(%rbp), %xmm0
               	vpcmpeqq	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, -0xb0(%rbp)
               	leaq	-0xf0(%rbp), %rsi
               	movq	(%rsi,%rax,8), %rsi
               	movq	(%rdx,%rax,8), %rdi
               	movq	$-0x1, %r8
               	xorl	%r9d, %r9d
               	movq	(%rcx,%rax,8), %rbx
               	cmpq	%rdi, %rbx
               	cmovgeq	%r9, %r8
               	cmpq	%r8, %rsi
               	jne	<addr>
               	leaq	-0xe0(%rbp), %rsi
               	movq	(%rsi,%rax,8), %rsi
               	movq	(%rdx,%rax,8), %rdi
               	movq	$-0x1, %r8
               	xorl	%r9d, %r9d
               	movq	(%rcx,%rax,8), %rbx
               	cmpq	%rdi, %rbx
               	cmovgq	%r9, %r8
               	cmpq	%r8, %rsi
               	jne	<addr>
               	leaq	-0xd0(%rbp), %rsi
               	movq	(%rsi,%rax,8), %rsi
               	leaq	-0x60(%rbp), %rdi
               	leaq	-0x70(%rbp), %r8
               	movq	(%r8,%rax,8), %r8
               	movq	$-0x1, %r9
               	xorl	%ebx, %ebx
               	movq	(%rdi,%rax,8), %rdi
               	cmpq	%r8, %rdi
               	cmovleq	%rbx, %r9
               	cmpq	%r9, %rsi
               	jne	<addr>
               	leaq	-0xc0(%rbp), %rsi
               	movq	(%rsi,%rax,8), %rsi
               	leaq	-0x60(%rbp), %rdi
               	leaq	-0x70(%rbp), %r8
               	movq	(%r8,%rax,8), %r8
               	movq	$-0x1, %r9
               	xorl	%ebx, %ebx
               	movq	(%rdi,%rax,8), %rdi
               	cmpq	%r8, %rdi
               	cmovlq	%rbx, %r9
               	cmpq	%r9, %rsi
               	jne	<addr>
               	leaq	-0xb0(%rbp), %rsi
               	movq	(%rsi,%rax,8), %rsi
               	leaq	-0x60(%rbp), %rdi
               	leaq	-0x70(%rbp), %r8
               	movq	(%r8,%rax,8), %r8
               	movq	$-0x1, %r9
               	xorl	%ebx, %ebx
               	movq	(%rdi,%rax,8), %rdi
               	cmpq	%r8, %rdi
               	cmovneq	%rbx, %r9
               	cmpq	%r9, %rsi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	-0x60(%rbp), %rax
               	leaq	-0x100(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x70(%rbp), %rax
               	leaq	-0x90(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	xorl	%eax, %eax
               	movq	%rax, -0xf0(%rbp)
               	movq	%rax, -0xe8(%rbp)
               	movq	%rax, -0xe0(%rbp)
               	movq	$-0x1, -0xd8(%rbp)
               	movq	$-0x1, -0xd0(%rbp)
               	movq	%rax, -0xc8(%rbp)
               	movq	$-0x1, -0xc0(%rbp)
               	movq	$-0x1, -0xb8(%rbp)
               	leaq	-0x100(%rbp), %rcx
               	leaq	-0x90(%rbp), %rdx
               	movups	-0x100(%rbp), %xmm0
               	movups	-0x90(%rbp), %xmm1
               	vpcmpeqq	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, -0xb0(%rbp)
               	leaq	-0xf0(%rbp), %rsi
               	movq	(%rsi,%rax,8), %rsi
               	movq	(%rdx,%rax,8), %rdi
               	movq	$-0x1, %r8
               	xorl	%r9d, %r9d
               	movq	(%rcx,%rax,8), %rbx
               	cmpq	%rdi, %rbx
               	cmovaeq	%r9, %r8
               	cmpq	%r8, %rsi
               	jne	<addr>
               	leaq	-0xe0(%rbp), %rsi
               	movq	(%rsi,%rax,8), %rsi
               	movq	(%rdx,%rax,8), %rdi
               	movq	$-0x1, %r8
               	xorl	%r9d, %r9d
               	movq	(%rcx,%rax,8), %rbx
               	cmpq	%rdi, %rbx
               	cmovaq	%r9, %r8
               	cmpq	%r8, %rsi
               	jne	<addr>
               	leaq	-0xd0(%rbp), %rsi
               	movq	(%rsi,%rax,8), %rsi
               	leaq	-0x100(%rbp), %rdi
               	leaq	-0x90(%rbp), %r8
               	movq	(%r8,%rax,8), %r8
               	movq	$-0x1, %r9
               	xorl	%ebx, %ebx
               	movq	(%rdi,%rax,8), %rdi
               	cmpq	%r8, %rdi
               	cmovbeq	%rbx, %r9
               	cmpq	%r9, %rsi
               	jne	<addr>
               	leaq	-0xc0(%rbp), %rsi
               	movq	(%rsi,%rax,8), %rsi
               	leaq	-0x100(%rbp), %rdi
               	leaq	-0x90(%rbp), %r8
               	movq	(%r8,%rax,8), %r8
               	movq	$-0x1, %r9
               	xorl	%ebx, %ebx
               	movq	(%rdi,%rax,8), %rdi
               	cmpq	%r8, %rdi
               	cmovbq	%rbx, %r9
               	cmpq	%r9, %rsi
               	jne	<addr>
               	leaq	-0xb0(%rbp), %rsi
               	movq	(%rsi,%rax,8), %rsi
               	leaq	-0x100(%rbp), %rdi
               	leaq	-0x90(%rbp), %r8
               	movq	(%r8,%rax,8), %r8
               	movq	$-0x1, %r9
               	xorl	%ebx, %ebx
               	movq	(%rdi,%rax,8), %rdi
               	cmpq	%r8, %rdi
               	cmovneq	%rbx, %r9
               	cmpq	%r9, %rsi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	-0xb0(%rbp), %rax
               	movl	$0x800f800, -0xb0(%rbp) # imm = 0x800F800
               	movl	$0x18d828f8, -0xac(%rbp) # imm = 0x18D828F8
               	movl	$0x20b84818, -0xa8(%rbp) # imm = 0x20B84818
               	movl	$0x403800e0, -0xa4(%rbp) # imm = 0x403800E0
               	leaq	-0xe0(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0xb0(%rbp), %rax
               	movl	$0xffe0, -0xb0(%rbp)    # imm = 0xFFE0
               	movl	$0xfe011f, -0xac(%rbp)  # imm = 0xFE011F
               	movl	$0x19fd0200, -0xa8(%rbp) # imm = 0x19FD0200
               	movl	$0x20100e7, -0xa4(%rbp) # imm = 0x20100E7
               	leaq	-0xd0(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0xb0(%rbp), %rax
               	movl	$0x1f10, -0xb0(%rbp)    # imm = 0x1F10
               	movl	$0x1f000f, -0xac(%rbp)  # imm = 0x1F000F
               	movl	$0xc1e0100, -0xa8(%rbp) # imm = 0xC1E0100
               	movl	$0x1000013, -0xa4(%rbp) # imm = 0x1000013
               	leaq	-0xc0(%rbp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	-0x10(%rbp), %rsi
               	movabsq	$-0x3fda7fffe00000, %rax # imm = 0xFFC0258000200000
               	movq	%rax, -0x10(%rbp)
               	leaq	-0x8(%rbp), %rdi
               	movabsq	$-0xffffffff0001, %rax  # imm = 0xFFFF00000000FFFF
               	movq	%rax, -0x8(%rbp)
               	xorl	%eax, %eax
               	leaq	-0xe0(%rbp), %rcx
               	movsbq	(%rcx,%rax), %r8
               	leaq	-0x110(%rbp), %rcx
               	movsbq	(%rcx,%rax), %rcx
               	movq	%rcx, %r9
               	shlq	$0x3, %r9
               	movsbq	%r9b, %r9
               	cmpl	%r9d, %r8d
               	jne	<addr>
               	leaq	-0xd0(%rbp), %r8
               	movsbq	(%r8,%rax), %r8
               	sarq	$0x2, %rcx
               	cmpl	%ecx, %r8d
               	jne	<addr>
               	movzbq	(%rdx,%rax), %rcx
               	leaq	-0xa0(%rbp), %r8
               	movzbq	(%r8,%rax), %r8
               	shrq	$0x3, %r8
               	cmpl	%r8d, %ecx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movswq	(%rsi,%rax,2), %rdx
               	leaq	-0x48(%rbp), %rcx
               	movswq	(%rcx,%rax,2), %r8
               	shlq	$0x5, %r8
               	movswq	%r8w, %r8
               	cmpl	%r8d, %edx
               	jne	<addr>
               	movswq	(%rdi,%rax,2), %rdx
               	movswq	(%rcx,%rax,2), %rcx
               	sarq	$0xf, %rcx
               	cmpl	%ecx, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x80(%rbp), %rdx
               	xorl	%eax, %eax
               	movups	-0x80(%rbp), %xmm0
               	movq	%rax, %xmm14
               	vpsubd	%xmm0, %xmm14, %xmm1
               	leaq	-0xd0(%rbp), %rsi
               	movups	%xmm1, -0xd0(%rbp)
               	vpcmpeqd	%xmm1, %xmm1, %xmm1
               	vpxor	%xmm1, %xmm0, %xmm0
               	leaq	-0xc0(%rbp), %rdi
               	movups	%xmm0, -0xc0(%rbp)
               	movups	-0x60(%rbp), %xmm0
               	movq	%rax, %xmm14
               	vpsubq	%xmm0, %xmm14, %xmm0
               	movups	-0xa0(%rbp), %xmm2
               	vpxor	%xmm1, %xmm2, %xmm1
               	movups	%xmm1, -0xb0(%rbp)
               	movl	(%rsi,%rax,4), %r8d
               	movslq	(%rdx,%rax,4), %rcx
               	movq	%rcx, %r9
               	negq	%r9
               	cmpl	%r9d, %r8d
               	jne	<addr>
               	movslq	(%rdi,%rax,4), %r8
               	xorq	$-0x1, %rcx
               	cmpq	%rcx, %r8
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	vmovq	%xmm0, %rax
               	cmpq	$0x1, %rax
               	jne	<addr>
               	vpextrq	$0x1, %xmm0, %rax
               	cmpq	$-0x5, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movzbq	-0xb0(%rbp), %rax
               	cmpl	$0x7f, %eax
               	je	<addr>
               	movl	$0xd, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	cmpb	$0x0, -0xaf(%rbp)
               	jne	<addr>
               	movzbq	-0xae(%rbp), %rax
               	cmpl	$0xff, %eax
               	jne	<addr>
               	movzbq	-0xad(%rbp), %rax
               	cmpl	$0xfe, %eax
               	jne	<addr>
               	movzbq	-0xac(%rbp), %rax
               	cmpl	$0x80, %eax
               	jne	<addr>
               	movzbq	-0xab(%rbp), %rax
               	cmpl	$0xfa, %eax
               	jne	<addr>
               	movzbq	-0xaa(%rbp), %rax
               	cmpl	$0x4, %eax
               	jne	<addr>
               	movzbq	-0xa9(%rbp), %rax
               	cmpl	$0xfc, %eax
               	jne	<addr>
               	movzbq	-0xa8(%rbp), %rax
               	cmpl	$0xfc, %eax
               	jne	<addr>
               	movzbq	-0xa7(%rbp), %rax
               	cmpl	$0xf6, %eax
               	jne	<addr>
               	movzbq	-0xa6(%rbp), %rax
               	cmpl	$0x8, %eax
               	jne	<addr>
               	movzbq	-0xa5(%rbp), %rax
               	cmpl	$0x9b, %eax
               	jne	<addr>
               	movzbq	-0xa4(%rbp), %rax
               	cmpl	$0x63, %eax
               	jne	<addr>
               	movzbq	-0xa3(%rbp), %rax
               	cmpl	$0xff, %eax
               	jne	<addr>
               	movzbq	-0xa2(%rbp), %rax
               	cmpl	$0xf8, %eax
               	jne	<addr>
               	movzbq	-0xa1(%rbp), %rax
               	cmpl	$0xf7, %eax
               	jne	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0xb, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0xa, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x9, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x8, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x7, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x6, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x5, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x4, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x3, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
