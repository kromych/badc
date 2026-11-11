
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
               	subq	$0x108, %rsp            # imm = 0x108
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	leaq	-0x100(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0xf0(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	-0xf0(%rbp), %xmm0
               	movups	-0x100(%rbp), %xmm1
               	pcmpgtb	%xmm1, %xmm0
               	movups	%xmm0, -0xe0(%rbp)
               	leaq	-0xa0(%rbp), %rsi
               	xorl	%eax, %eax
               	movb	$-0x1, -0xa0(%rbp)
               	movb	$-0x1, -0x9f(%rbp)
               	movb	$-0x1, -0x9e(%rbp)
               	movb	%al, -0x9d(%rbp)
               	movb	%al, -0x9c(%rbp)
               	movb	$-0x1, -0x9b(%rbp)
               	movb	$-0x1, -0x9a(%rbp)
               	movb	$0x0, -0x99(%rbp)
               	movb	$-0x1, -0x98(%rbp)
               	movb	$0x0, -0x97(%rbp)
               	movb	$0x0, -0x96(%rbp)
               	movb	$-0x1, -0x95(%rbp)
               	movb	$-0x1, -0x94(%rbp)
               	movb	$-0x1, -0x93(%rbp)
               	movb	$-0x1, -0x92(%rbp)
               	movb	$-0x1, -0x91(%rbp)
               	leaq	-0xd0(%rbp), %rdx
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	-0x100(%rbp), %xmm0
               	movups	-0xf0(%rbp), %xmm1
               	pcmpgtb	%xmm1, %xmm0
               	movups	%xmm0, -0xc0(%rbp)
               	leaq	-0xa0(%rbp), %rsi
               	movb	$0x0, -0xa0(%rbp)
               	movb	$0x0, -0x9f(%rbp)
               	movb	$-0x1, -0x9e(%rbp)
               	movb	$-0x1, -0x9d(%rbp)
               	movb	$-0x1, -0x9c(%rbp)
               	movb	$-0x1, -0x9b(%rbp)
               	movb	$0x0, -0x9a(%rbp)
               	movb	$-0x1, -0x99(%rbp)
               	movb	$-0x1, -0x98(%rbp)
               	movb	$-0x1, -0x97(%rbp)
               	movb	$-0x1, -0x96(%rbp)
               	xorl	%ecx, %ecx
               	movb	%cl, -0x95(%rbp)
               	movb	%cl, -0x94(%rbp)
               	movb	%cl, -0x93(%rbp)
               	movq	$-0x1, %rdx
               	movb	%dl, -0x92(%rbp)
               	movb	%cl, -0x91(%rbp)
               	leaq	-0xb0(%rbp), %rdi
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	-0x100(%rbp), %rsi
               	leaq	-0xf0(%rbp), %rdi
               	movups	-0x100(%rbp), %xmm0
               	movups	-0xf0(%rbp), %xmm1
               	pcmpeqb	%xmm1, %xmm0
               	movups	%xmm0, -0xa0(%rbp)
               	leaq	-0xe0(%rbp), %r8
               	movsbq	(%r8,%rax), %r8
               	movsbq	(%rdi,%rax), %r9
               	movsbq	(%rsi,%rax), %rbx
               	cmpl	%r9d, %ebx
               	movq	%rcx, %r9
               	cmovlq	%rdx, %r9
               	cmpl	%r9d, %r8d
               	jne	<addr>
               	leaq	-0xd0(%rbp), %r8
               	movsbq	(%r8,%rax), %r8
               	leaq	-0x100(%rbp), %r9
               	leaq	-0xf0(%rbp), %rbx
               	movsbq	(%rbx,%rax), %rbx
               	movq	$-0x1, %r12
               	xorl	%r13d, %r13d
               	movsbq	(%r9,%rax), %r9
               	cmpl	%ebx, %r9d
               	movq	%r13, %r9
               	cmovleq	%r12, %r9
               	cmpl	%r9d, %r8d
               	jne	<addr>
               	leaq	-0xc0(%rbp), %r8
               	movsbq	(%r8,%rax), %r8
               	leaq	-0x100(%rbp), %r9
               	leaq	-0xf0(%rbp), %rbx
               	movsbq	(%rbx,%rax), %rbx
               	movq	$-0x1, %r12
               	xorl	%r13d, %r13d
               	movsbq	(%r9,%rax), %r9
               	cmpl	%ebx, %r9d
               	movq	%r13, %r9
               	cmovgq	%r12, %r9
               	cmpl	%r9d, %r8d
               	jne	<addr>
               	leaq	-0xb0(%rbp), %r8
               	movsbq	(%r8,%rax), %r8
               	leaq	-0x100(%rbp), %r9
               	leaq	-0xf0(%rbp), %rbx
               	movsbq	(%rbx,%rax), %rbx
               	movq	$-0x1, %r12
               	xorl	%r13d, %r13d
               	movsbq	(%r9,%rax), %r9
               	cmpl	%ebx, %r9d
               	movq	%r13, %r9
               	cmovgeq	%r12, %r9
               	cmpl	%r9d, %r8d
               	jne	<addr>
               	leaq	-0xa0(%rbp), %r8
               	movsbq	(%r8,%rax), %r8
               	leaq	-0x100(%rbp), %r9
               	leaq	-0xf0(%rbp), %rbx
               	movsbq	(%rbx,%rax), %rbx
               	movq	$-0x1, %r12
               	xorl	%r13d, %r13d
               	movsbq	(%r9,%rax), %r9
               	cmpl	%ebx, %r9d
               	movq	%r13, %r9
               	cmoveq	%r12, %r9
               	cmpl	%r9d, %r8d
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x100(%rbp), %rax
               	leaq	-0x90(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0xf0(%rbp), %rax
               	leaq	-0x80(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0xa0(%rbp), %rsi
               	xorl	%eax, %eax
               	movb	%al, -0xa0(%rbp)
               	movb	%al, -0x9f(%rbp)
               	movb	%al, -0x9e(%rbp)
               	movb	$-0x1, -0x9d(%rbp)
               	movb	$-0x1, -0x9c(%rbp)
               	movb	%al, -0x9b(%rbp)
               	movb	%al, -0x9a(%rbp)
               	movb	$-0x1, -0x99(%rbp)
               	movb	$0x0, -0x98(%rbp)
               	movb	$0x0, -0x97(%rbp)
               	movb	$0x0, -0x96(%rbp)
               	movb	$-0x1, -0x95(%rbp)
               	movb	$-0x1, -0x94(%rbp)
               	movb	$-0x1, -0x93(%rbp)
               	movb	$0x0, -0x92(%rbp)
               	movb	$-0x1, -0x91(%rbp)
               	leaq	-0xe0(%rbp), %rdi
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	-0xa0(%rbp), %rdi
               	movb	$0x0, -0xa0(%rbp)
               	movb	$0x0, -0x9f(%rbp)
               	movb	$-0x1, -0x9e(%rbp)
               	movb	$-0x1, -0x9d(%rbp)
               	movb	$-0x1, -0x9c(%rbp)
               	movb	$-0x1, -0x9b(%rbp)
               	movb	$0x0, -0x9a(%rbp)
               	movb	$-0x1, -0x99(%rbp)
               	movb	$-0x1, -0x98(%rbp)
               	movb	$0x0, -0x97(%rbp)
               	movb	$0x0, -0x96(%rbp)
               	movb	$-0x1, -0x95(%rbp)
               	movb	$-0x1, -0x94(%rbp)
               	movb	$-0x1, -0x93(%rbp)
               	movb	$-0x1, -0x92(%rbp)
               	movb	$-0x1, -0x91(%rbp)
               	leaq	-0xd0(%rbp), %rdx
               	movups	(%rdi), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	-0xa0(%rbp), %rsi
               	movb	$-0x1, -0xa0(%rbp)
               	movb	$-0x1, -0x9f(%rbp)
               	movb	$0x0, -0x9e(%rbp)
               	movb	$0x0, -0x9d(%rbp)
               	movb	$0x0, -0x9c(%rbp)
               	movb	$0x0, -0x9b(%rbp)
               	movb	$-0x1, -0x9a(%rbp)
               	movb	$0x0, -0x99(%rbp)
               	movb	$0x0, -0x98(%rbp)
               	movb	$-0x1, -0x97(%rbp)
               	movb	$-0x1, -0x96(%rbp)
               	movb	$0x0, -0x95(%rbp)
               	movb	$0x0, -0x94(%rbp)
               	movb	$0x0, -0x93(%rbp)
               	movb	$0x0, -0x92(%rbp)
               	movb	$0x0, -0x91(%rbp)
               	leaq	-0xc0(%rbp), %rcx
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0xa0(%rbp), %rsi
               	movb	$-0x1, -0xa0(%rbp)
               	movb	$-0x1, -0x9f(%rbp)
               	movb	$-0x1, -0x9e(%rbp)
               	movb	$0x0, -0x9d(%rbp)
               	movb	$0x0, -0x9c(%rbp)
               	movb	$-0x1, -0x9b(%rbp)
               	movb	$-0x1, -0x9a(%rbp)
               	movb	$0x0, -0x99(%rbp)
               	movb	$-0x1, -0x98(%rbp)
               	movb	$-0x1, -0x97(%rbp)
               	movb	$-0x1, -0x96(%rbp)
               	movb	$0x0, -0x95(%rbp)
               	movb	$0x0, -0x94(%rbp)
               	xorl	%ecx, %ecx
               	movb	%cl, -0x93(%rbp)
               	movq	$-0x1, %rdx
               	movb	%dl, -0x92(%rbp)
               	movb	%cl, -0x91(%rbp)
               	leaq	-0xb0(%rbp), %rdi
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	-0x90(%rbp), %rsi
               	leaq	-0x80(%rbp), %rdi
               	movups	-0x90(%rbp), %xmm0
               	movups	-0x80(%rbp), %xmm1
               	pcmpeqb	%xmm1, %xmm0
               	movups	%xmm0, -0xa0(%rbp)
               	leaq	-0xe0(%rbp), %r8
               	movsbq	(%r8,%rax), %r8
               	movzbq	(%rdi,%rax), %r9
               	movzbq	(%rsi,%rax), %rbx
               	cmpl	%r9d, %ebx
               	movq	%rcx, %r9
               	cmovlq	%rdx, %r9
               	cmpl	%r9d, %r8d
               	jne	<addr>
               	leaq	-0xd0(%rbp), %r8
               	movsbq	(%r8,%rax), %r8
               	leaq	-0x90(%rbp), %r9
               	leaq	-0x80(%rbp), %rbx
               	movzbq	(%rbx,%rax), %rbx
               	movq	$-0x1, %r12
               	xorl	%r13d, %r13d
               	movzbq	(%r9,%rax), %r9
               	cmpl	%ebx, %r9d
               	movq	%r13, %r9
               	cmovleq	%r12, %r9
               	cmpl	%r9d, %r8d
               	jne	<addr>
               	leaq	-0xc0(%rbp), %r8
               	movsbq	(%r8,%rax), %r8
               	leaq	-0x90(%rbp), %r9
               	leaq	-0x80(%rbp), %rbx
               	movzbq	(%rbx,%rax), %rbx
               	movq	$-0x1, %r12
               	xorl	%r13d, %r13d
               	movzbq	(%r9,%rax), %r9
               	cmpl	%ebx, %r9d
               	movq	%r13, %r9
               	cmovgq	%r12, %r9
               	cmpl	%r9d, %r8d
               	jne	<addr>
               	leaq	-0xb0(%rbp), %r8
               	movsbq	(%r8,%rax), %r8
               	leaq	-0x90(%rbp), %r9
               	leaq	-0x80(%rbp), %rbx
               	movzbq	(%rbx,%rax), %rbx
               	movq	$-0x1, %r12
               	xorl	%r13d, %r13d
               	movzbq	(%r9,%rax), %r9
               	cmpl	%ebx, %r9d
               	movq	%r13, %r9
               	cmovgeq	%r12, %r9
               	cmpl	%r9d, %r8d
               	jne	<addr>
               	leaq	-0xa0(%rbp), %r8
               	movsbq	(%r8,%rax), %r8
               	leaq	-0x90(%rbp), %r9
               	leaq	-0x80(%rbp), %rbx
               	movzbq	(%rbx,%rax), %rbx
               	movq	$-0x1, %r12
               	xorl	%r13d, %r13d
               	movzbq	(%r9,%rax), %r9
               	cmpl	%ebx, %r9d
               	movq	%r13, %r9
               	cmoveq	%r12, %r9
               	cmpl	%r9d, %r8d
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
               	pcmpgtw	%xmm1, %xmm0
               	movsd	%xmm0, -0x28(%rbp)
               	xorl	%eax, %eax
               	movw	$0xffff, -0x20(%rbp)    # imm = 0xFFFF
               	movw	$0xffff, -0x1e(%rbp)    # imm = 0xFFFF
               	movw	%ax, -0x1c(%rbp)
               	movw	%ax, -0x1a(%rbp)
               	movsd	-0x48(%rbp), %xmm0
               	movsd	-0x40(%rbp), %xmm1
               	pcmpgtw	%xmm1, %xmm0
               	movsd	%xmm0, -0x18(%rbp)
               	xorl	%edx, %edx
               	movw	%dx, -0x10(%rbp)
               	movw	$0xffff, -0xe(%rbp)     # imm = 0xFFFF
               	movw	$0xffff, -0xc(%rbp)     # imm = 0xFFFF
               	movw	$0xffff, -0xa(%rbp)     # imm = 0xFFFF
               	leaq	-0x48(%rbp), %rcx
               	leaq	-0x40(%rbp), %rsi
               	movsd	-0x48(%rbp), %xmm0
               	movsd	-0x40(%rbp), %xmm1
               	pcmpeqw	%xmm1, %xmm0
               	movsd	%xmm0, -0x8(%rbp)
               	leaq	-0x28(%rbp), %rdi
               	movswq	(%rdi,%rax,2), %rdi
               	movswq	(%rsi,%rax,2), %r8
               	movq	$-0x1, %r9
               	movswq	(%rcx,%rax,2), %rbx
               	cmpl	%r8d, %ebx
               	movq	%rdx, %r8
               	cmovlq	%r9, %r8
               	cmpl	%r8d, %edi
               	jne	<addr>
               	leaq	-0x20(%rbp), %rdi
               	movswq	(%rdi,%rax,2), %rdi
               	leaq	-0x40(%rbp), %r8
               	movswq	(%r8,%rax,2), %r8
               	movq	$-0x1, %r9
               	xorl	%ebx, %ebx
               	movswq	(%rcx,%rax,2), %r12
               	cmpl	%r8d, %r12d
               	movq	%rbx, %r8
               	cmovleq	%r9, %r8
               	cmpl	%r8d, %edi
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
               	movq	%r12, %r8
               	cmovgq	%rbx, %r8
               	cmpl	%r8d, %edi
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
               	movq	%r12, %r8
               	cmovgeq	%rbx, %r8
               	cmpl	%r8d, %edi
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
               	movq	%r12, %r8
               	cmoveq	%rbx, %r8
               	cmpl	%r8d, %edi
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
               	movw	%ax, -0x28(%rbp)
               	movw	%ax, -0x26(%rbp)
               	movw	$0xffff, -0x24(%rbp)    # imm = 0xFFFF
               	movw	%ax, -0x22(%rbp)
               	movw	%ax, -0x20(%rbp)
               	movw	$0xffff, -0x1e(%rbp)    # imm = 0xFFFF
               	movw	$0xffff, -0x1c(%rbp)    # imm = 0xFFFF
               	movw	%ax, -0x1a(%rbp)
               	movw	$0xffff, -0x18(%rbp)    # imm = 0xFFFF
               	movw	$0x0, -0x16(%rbp)
               	movw	$0x0, -0x14(%rbp)
               	movw	$0xffff, -0x12(%rbp)    # imm = 0xFFFF
               	movw	$0xffff, -0x10(%rbp)    # imm = 0xFFFF
               	movw	$0xffff, -0xe(%rbp)     # imm = 0xFFFF
               	movw	$0x0, -0xc(%rbp)
               	movw	$0xffff, -0xa(%rbp)     # imm = 0xFFFF
               	leaq	-0x38(%rbp), %rcx
               	leaq	-0x30(%rbp), %rdx
               	movsd	-0x38(%rbp), %xmm0
               	movsd	-0x30(%rbp), %xmm1
               	pcmpeqw	%xmm1, %xmm0
               	movsd	%xmm0, -0x8(%rbp)
               	leaq	-0x28(%rbp), %rsi
               	movswq	(%rsi,%rax,2), %rsi
               	movzwq	(%rdx,%rax,2), %rdi
               	movq	$-0x1, %r8
               	xorl	%r9d, %r9d
               	movzwq	(%rcx,%rax,2), %rbx
               	cmpl	%edi, %ebx
               	movq	%r9, %rdi
               	cmovlq	%r8, %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	leaq	-0x20(%rbp), %rsi
               	movswq	(%rsi,%rax,2), %rsi
               	movzwq	(%rdx,%rax,2), %rdi
               	movq	$-0x1, %r8
               	xorl	%r9d, %r9d
               	movzwq	(%rcx,%rax,2), %rbx
               	cmpl	%edi, %ebx
               	movq	%r9, %rdi
               	cmovleq	%r8, %rdi
               	cmpl	%edi, %esi
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
               	movq	%rbx, %rdi
               	cmovgq	%r9, %rdi
               	cmpl	%edi, %esi
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
               	movq	%rbx, %rdi
               	cmovgeq	%r9, %rdi
               	cmpl	%edi, %esi
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
               	movq	%rbx, %rdi
               	cmoveq	%r9, %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x70(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x60(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	-0x60(%rbp), %xmm0
               	movups	-0x70(%rbp), %xmm1
               	pcmpgtd	%xmm1, %xmm0
               	movups	%xmm0, -0xe0(%rbp)
               	xorl	%eax, %eax
               	movl	$0xffffffff, -0xd0(%rbp) # imm = 0xFFFFFFFF
               	movl	%eax, -0xcc(%rbp)
               	movl	$0xffffffff, -0xc8(%rbp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, -0xc4(%rbp) # imm = 0xFFFFFFFF
               	movups	-0x70(%rbp), %xmm0
               	movups	-0x60(%rbp), %xmm1
               	pcmpgtd	%xmm1, %xmm0
               	movups	%xmm0, -0xc0(%rbp)
               	xorl	%edx, %edx
               	movl	%edx, -0xb0(%rbp)
               	movl	$0xffffffff, -0xac(%rbp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, -0xa8(%rbp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, -0xa4(%rbp) # imm = 0xFFFFFFFF
               	leaq	-0x70(%rbp), %rcx
               	leaq	-0x60(%rbp), %rsi
               	movups	-0x70(%rbp), %xmm0
               	movups	-0x60(%rbp), %xmm1
               	pcmpeqd	%xmm1, %xmm0
               	movups	%xmm0, -0xa0(%rbp)
               	leaq	-0xe0(%rbp), %rdi
               	movl	(%rdi,%rax,4), %edi
               	movl	(%rsi,%rax,4), %r8d
               	movq	$-0x1, %r9
               	movl	(%rcx,%rax,4), %ebx
               	cmpl	%r8d, %ebx
               	movq	%rdx, %r8
               	cmovlq	%r9, %r8
               	cmpl	%r8d, %edi
               	jne	<addr>
               	leaq	-0xd0(%rbp), %rdi
               	movl	(%rdi,%rax,4), %edi
               	leaq	-0x60(%rbp), %r8
               	movl	(%r8,%rax,4), %r8d
               	movq	$-0x1, %r9
               	xorl	%ebx, %ebx
               	movl	(%rcx,%rax,4), %r12d
               	cmpl	%r8d, %r12d
               	movq	%rbx, %r8
               	cmovleq	%r9, %r8
               	cmpl	%r8d, %edi
               	jne	<addr>
               	leaq	-0xc0(%rbp), %rdi
               	movl	(%rdi,%rax,4), %edi
               	leaq	-0x70(%rbp), %r8
               	leaq	-0x60(%rbp), %r9
               	movl	(%r9,%rax,4), %r9d
               	movq	$-0x1, %rbx
               	xorl	%r12d, %r12d
               	movl	(%r8,%rax,4), %r8d
               	cmpl	%r9d, %r8d
               	movq	%r12, %r8
               	cmovgq	%rbx, %r8
               	cmpl	%r8d, %edi
               	jne	<addr>
               	leaq	-0xb0(%rbp), %rdi
               	movl	(%rdi,%rax,4), %edi
               	leaq	-0x70(%rbp), %r8
               	leaq	-0x60(%rbp), %r9
               	movl	(%r9,%rax,4), %r9d
               	movq	$-0x1, %rbx
               	xorl	%r12d, %r12d
               	movl	(%r8,%rax,4), %r8d
               	cmpl	%r9d, %r8d
               	movq	%r12, %r8
               	cmovgeq	%rbx, %r8
               	cmpl	%r8d, %edi
               	jne	<addr>
               	leaq	-0xa0(%rbp), %rdi
               	movl	(%rdi,%rax,4), %edi
               	leaq	-0x70(%rbp), %r8
               	leaq	-0x60(%rbp), %r9
               	movl	(%r9,%rax,4), %r9d
               	movq	$-0x1, %rbx
               	xorl	%r12d, %r12d
               	movl	(%r8,%rax,4), %r8d
               	cmpl	%r9d, %r8d
               	movq	%r12, %r8
               	cmoveq	%rbx, %r8
               	cmpl	%r8d, %edi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x70(%rbp), %rax
               	leaq	-0xf0(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x60(%rbp), %rax
               	leaq	-0x80(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	xorl	%eax, %eax
               	movl	%eax, -0xe0(%rbp)
               	movl	$0xffffffff, -0xdc(%rbp) # imm = 0xFFFFFFFF
               	movl	%eax, -0xd8(%rbp)
               	movl	%eax, -0xd4(%rbp)
               	movl	%eax, -0xd0(%rbp)
               	movl	$0xffffffff, -0xcc(%rbp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, -0xc8(%rbp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, -0xc4(%rbp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, -0xc0(%rbp) # imm = 0xFFFFFFFF
               	movl	$0x0, -0xbc(%rbp)
               	movl	$0x0, -0xb8(%rbp)
               	movl	$0x0, -0xb4(%rbp)
               	movl	$0xffffffff, -0xb0(%rbp) # imm = 0xFFFFFFFF
               	movl	$0x0, -0xac(%rbp)
               	movl	$0xffffffff, -0xa8(%rbp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, -0xa4(%rbp) # imm = 0xFFFFFFFF
               	leaq	-0xf0(%rbp), %rcx
               	leaq	-0x80(%rbp), %rdx
               	movups	-0xf0(%rbp), %xmm0
               	movups	-0x80(%rbp), %xmm1
               	pcmpeqd	%xmm1, %xmm0
               	movups	%xmm0, -0xa0(%rbp)
               	leaq	-0xe0(%rbp), %rsi
               	movl	(%rsi,%rax,4), %esi
               	movl	(%rdx,%rax,4), %edi
               	movq	$-0x1, %r8
               	xorl	%r9d, %r9d
               	movl	(%rcx,%rax,4), %ebx
               	cmpl	%edi, %ebx
               	movq	%r9, %rdi
               	cmovbq	%r8, %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	leaq	-0xd0(%rbp), %rsi
               	movl	(%rsi,%rax,4), %esi
               	movl	(%rdx,%rax,4), %edi
               	movq	$-0x1, %r8
               	xorl	%r9d, %r9d
               	movl	(%rcx,%rax,4), %ebx
               	cmpl	%edi, %ebx
               	movq	%r9, %rdi
               	cmovbeq	%r8, %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	leaq	-0xc0(%rbp), %rsi
               	movl	(%rsi,%rax,4), %esi
               	leaq	-0xf0(%rbp), %rdi
               	leaq	-0x80(%rbp), %r8
               	movl	(%r8,%rax,4), %r8d
               	movq	$-0x1, %r9
               	xorl	%ebx, %ebx
               	movl	(%rdi,%rax,4), %edi
               	cmpl	%r8d, %edi
               	movq	%rbx, %rdi
               	cmovaq	%r9, %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	leaq	-0xb0(%rbp), %rsi
               	movl	(%rsi,%rax,4), %esi
               	leaq	-0xf0(%rbp), %rdi
               	leaq	-0x80(%rbp), %r8
               	movl	(%r8,%rax,4), %r8d
               	movq	$-0x1, %r9
               	xorl	%ebx, %ebx
               	movl	(%rdi,%rax,4), %edi
               	cmpl	%r8d, %edi
               	movq	%rbx, %rdi
               	cmovaeq	%r9, %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	leaq	-0xa0(%rbp), %rsi
               	movl	(%rsi,%rax,4), %esi
               	leaq	-0xf0(%rbp), %rdi
               	leaq	-0x80(%rbp), %r8
               	movl	(%r8,%rax,4), %r8d
               	movq	$-0x1, %r9
               	xorl	%ebx, %ebx
               	movl	(%rdi,%rax,4), %edi
               	cmpl	%r8d, %edi
               	movq	%rbx, %rdi
               	cmoveq	%r9, %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x80(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x60(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	-0x60(%rbp), %xmm0
               	movups	-0x80(%rbp), %xmm1
               	pcmpgtq	%xmm1, %xmm0
               	movups	%xmm0, -0xe0(%rbp)
               	xorl	%eax, %eax
               	movq	$-0x1, -0xd0(%rbp)
               	movq	$-0x1, -0xc8(%rbp)
               	movups	-0x80(%rbp), %xmm0
               	movups	-0x60(%rbp), %xmm1
               	pcmpgtq	%xmm1, %xmm0
               	movups	%xmm0, -0xc0(%rbp)
               	movq	%rax, -0xb0(%rbp)
               	movq	$-0x1, -0xa8(%rbp)
               	leaq	-0x80(%rbp), %rcx
               	leaq	-0x60(%rbp), %rdx
               	movups	-0x80(%rbp), %xmm0
               	movups	-0x60(%rbp), %xmm1
               	pcmpeqq	%xmm1, %xmm0
               	movups	%xmm0, -0xa0(%rbp)
               	leaq	-0xe0(%rbp), %rsi
               	movq	(%rsi,%rax,8), %rsi
               	movq	(%rdx,%rax,8), %rdi
               	movq	$-0x1, %r8
               	xorl	%r9d, %r9d
               	movq	(%rcx,%rax,8), %rbx
               	cmpq	%rdi, %rbx
               	movq	%r9, %rdi
               	cmovlq	%r8, %rdi
               	cmpq	%rdi, %rsi
               	jne	<addr>
               	leaq	-0xd0(%rbp), %rsi
               	movq	(%rsi,%rax,8), %rsi
               	movq	(%rdx,%rax,8), %rdi
               	movq	$-0x1, %r8
               	xorl	%r9d, %r9d
               	movq	(%rcx,%rax,8), %rbx
               	cmpq	%rdi, %rbx
               	movq	%r9, %rdi
               	cmovleq	%r8, %rdi
               	cmpq	%rdi, %rsi
               	jne	<addr>
               	leaq	-0xc0(%rbp), %rsi
               	movq	(%rsi,%rax,8), %rsi
               	leaq	-0x80(%rbp), %rdi
               	leaq	-0x60(%rbp), %r8
               	movq	(%r8,%rax,8), %r8
               	movq	$-0x1, %r9
               	xorl	%ebx, %ebx
               	movq	(%rdi,%rax,8), %rdi
               	cmpq	%r8, %rdi
               	movq	%rbx, %rdi
               	cmovgq	%r9, %rdi
               	cmpq	%rdi, %rsi
               	jne	<addr>
               	leaq	-0xb0(%rbp), %rsi
               	movq	(%rsi,%rax,8), %rsi
               	leaq	-0x80(%rbp), %rdi
               	leaq	-0x60(%rbp), %r8
               	movq	(%r8,%rax,8), %r8
               	movq	$-0x1, %r9
               	xorl	%ebx, %ebx
               	movq	(%rdi,%rax,8), %rdi
               	cmpq	%r8, %rdi
               	movq	%rbx, %rdi
               	cmovgeq	%r9, %rdi
               	cmpq	%rdi, %rsi
               	jne	<addr>
               	leaq	-0xa0(%rbp), %rsi
               	movq	(%rsi,%rax,8), %rsi
               	leaq	-0x80(%rbp), %rdi
               	leaq	-0x60(%rbp), %r8
               	movq	(%r8,%rax,8), %r8
               	movq	$-0x1, %r9
               	xorl	%ebx, %ebx
               	movq	(%rdi,%rax,8), %rdi
               	cmpq	%r8, %rdi
               	movq	%rbx, %rdi
               	cmoveq	%r9, %rdi
               	cmpq	%rdi, %rsi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	-0x80(%rbp), %rax
               	leaq	-0xf0(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x60(%rbp), %rax
               	leaq	-0x80(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	xorl	%eax, %eax
               	movq	%rax, -0xe0(%rbp)
               	movq	%rax, -0xd8(%rbp)
               	movq	%rax, -0xd0(%rbp)
               	movq	$-0x1, -0xc8(%rbp)
               	movq	$-0x1, -0xc0(%rbp)
               	movq	%rax, -0xb8(%rbp)
               	movq	$-0x1, -0xb0(%rbp)
               	movq	$-0x1, -0xa8(%rbp)
               	leaq	-0xf0(%rbp), %rcx
               	leaq	-0x80(%rbp), %rdx
               	movups	-0xf0(%rbp), %xmm0
               	movups	-0x80(%rbp), %xmm1
               	pcmpeqq	%xmm1, %xmm0
               	movups	%xmm0, -0xa0(%rbp)
               	leaq	-0xe0(%rbp), %rsi
               	movq	(%rsi,%rax,8), %rsi
               	movq	(%rdx,%rax,8), %rdi
               	movq	$-0x1, %r8
               	xorl	%r9d, %r9d
               	movq	(%rcx,%rax,8), %rbx
               	cmpq	%rdi, %rbx
               	movq	%r9, %rdi
               	cmovbq	%r8, %rdi
               	cmpq	%rdi, %rsi
               	jne	<addr>
               	leaq	-0xd0(%rbp), %rsi
               	movq	(%rsi,%rax,8), %rsi
               	movq	(%rdx,%rax,8), %rdi
               	movq	$-0x1, %r8
               	xorl	%r9d, %r9d
               	movq	(%rcx,%rax,8), %rbx
               	cmpq	%rdi, %rbx
               	movq	%r9, %rdi
               	cmovbeq	%r8, %rdi
               	cmpq	%rdi, %rsi
               	jne	<addr>
               	leaq	-0xc0(%rbp), %rsi
               	movq	(%rsi,%rax,8), %rsi
               	leaq	-0xf0(%rbp), %rdi
               	leaq	-0x80(%rbp), %r8
               	movq	(%r8,%rax,8), %r8
               	movq	$-0x1, %r9
               	xorl	%ebx, %ebx
               	movq	(%rdi,%rax,8), %rdi
               	cmpq	%r8, %rdi
               	movq	%rbx, %rdi
               	cmovaq	%r9, %rdi
               	cmpq	%rdi, %rsi
               	jne	<addr>
               	leaq	-0xb0(%rbp), %rsi
               	movq	(%rsi,%rax,8), %rsi
               	leaq	-0xf0(%rbp), %rdi
               	leaq	-0x80(%rbp), %r8
               	movq	(%r8,%rax,8), %r8
               	movq	$-0x1, %r9
               	xorl	%ebx, %ebx
               	movq	(%rdi,%rax,8), %rdi
               	cmpq	%r8, %rdi
               	movq	%rbx, %rdi
               	cmovaeq	%r9, %rdi
               	cmpq	%rdi, %rsi
               	jne	<addr>
               	leaq	-0xa0(%rbp), %rsi
               	movq	(%rsi,%rax,8), %rsi
               	leaq	-0xf0(%rbp), %rdi
               	leaq	-0x80(%rbp), %r8
               	movq	(%r8,%rax,8), %r8
               	movq	$-0x1, %r9
               	xorl	%ebx, %ebx
               	movq	(%rdi,%rax,8), %rdi
               	cmpq	%r8, %rdi
               	movq	%rbx, %rdi
               	cmoveq	%r9, %rdi
               	cmpq	%rdi, %rsi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	-0xa0(%rbp), %rdx
               	movb	$0x0, -0xa0(%rbp)
               	movb	$-0x8, -0x9f(%rbp)
               	movb	$0x0, -0x9e(%rbp)
               	movb	$0x8, -0x9d(%rbp)
               	movb	$-0x8, -0x9c(%rbp)
               	movb	$0x28, -0x9b(%rbp)
               	movb	$-0x28, -0x9a(%rbp)
               	movb	$0x18, -0x99(%rbp)
               	movb	$0x18, -0x98(%rbp)
               	movb	$0x48, -0x97(%rbp)
               	movb	$-0x48, -0x96(%rbp)
               	movb	$0x20, -0x95(%rbp)
               	movb	$-0x20, -0x94(%rbp)
               	movb	$0x0, -0x93(%rbp)
               	movb	$0x38, -0x92(%rbp)
               	movb	$0x40, -0x91(%rbp)
               	leaq	-0xd0(%rbp), %rcx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0xa0(%rbp), %rdi
               	movb	$-0x20, -0xa0(%rbp)
               	movb	$-0x1, -0x9f(%rbp)
               	movb	$0x0, -0x9e(%rbp)
               	movb	$0x0, -0x9d(%rbp)
               	movb	$0x1f, -0x9c(%rbp)
               	movb	$0x1, -0x9b(%rbp)
               	movb	$-0x2, -0x9a(%rbp)
               	movb	$0x0, -0x99(%rbp)
               	movb	$0x0, -0x98(%rbp)
               	movb	$0x2, -0x97(%rbp)
               	movb	$-0x3, -0x96(%rbp)
               	movb	$0x19, -0x95(%rbp)
               	movb	$-0x19, -0x94(%rbp)
               	movb	$0x0, -0x93(%rbp)
               	movb	$0x1, -0x92(%rbp)
               	movb	$0x2, -0x91(%rbp)
               	leaq	-0xc0(%rbp), %rdx
               	movups	(%rdi), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	-0xa0(%rbp), %rsi
               	movb	$0x10, -0xa0(%rbp)
               	movb	$0x1f, -0x9f(%rbp)
               	movb	$0x0, -0x9e(%rbp)
               	movb	$0x0, -0x9d(%rbp)
               	movb	$0xf, -0x9c(%rbp)
               	movb	$0x0, -0x9b(%rbp)
               	movb	$0x1f, -0x9a(%rbp)
               	movb	$0x0, -0x99(%rbp)
               	movb	$0x0, -0x98(%rbp)
               	movb	$0x1, -0x97(%rbp)
               	movb	$0x1e, -0x96(%rbp)
               	movb	$0xc, -0x95(%rbp)
               	movb	$0x13, -0x94(%rbp)
               	movb	$0x0, -0x93(%rbp)
               	movb	$0x0, -0x92(%rbp)
               	movb	$0x1, -0x91(%rbp)
               	leaq	-0xb0(%rbp), %rdx
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	-0x10(%rbp), %rsi
               	movw	$0x0, -0x10(%rbp)
               	movw	$0x20, -0xe(%rbp)
               	movw	$0x2580, -0xc(%rbp)     # imm = 0x2580
               	movw	$0xffc0, -0xa(%rbp)     # imm = 0xFFC0
               	leaq	-0x8(%rbp), %rdi
               	movw	$0xffff, -0x8(%rbp)     # imm = 0xFFFF
               	movw	$0x0, -0x6(%rbp)
               	movw	$0x0, -0x4(%rbp)
               	movw	$0xffff, -0x2(%rbp)     # imm = 0xFFFF
               	xorl	%eax, %eax
               	leaq	-0xd0(%rbp), %rcx
               	movsbq	(%rcx,%rax), %r8
               	leaq	-0x100(%rbp), %rcx
               	movsbq	(%rcx,%rax), %rcx
               	movq	%rcx, %r9
               	shlq	$0x3, %r9
               	movsbq	%r9b, %r9
               	cmpl	%r9d, %r8d
               	jne	<addr>
               	leaq	-0xc0(%rbp), %r8
               	movsbq	(%r8,%rax), %r8
               	sarq	$0x2, %rcx
               	cmpl	%ecx, %r8d
               	jne	<addr>
               	movzbq	(%rdx,%rax), %rcx
               	leaq	-0x90(%rbp), %r8
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
               	xorl	%eax, %eax
               	leaq	-0xb0(%rbp), %rdx
               	movl	$0x5, -0xb0(%rbp)
               	movl	$0x80000001, -0xac(%rbp) # imm = 0x80000001
               	movl	$0xfffffffd, -0xa8(%rbp) # imm = 0xFFFFFFFD
               	movl	%eax, -0xa4(%rbp)
               	leaq	-0xa0(%rbp), %rsi
               	movl	$0x4, -0xa0(%rbp)
               	movl	$0x80000000, -0x9c(%rbp) # imm = 0x80000000
               	movl	$0xfffffffc, -0x98(%rbp) # imm = 0xFFFFFFFC
               	movl	$0xffffffff, -0x94(%rbp) # imm = 0xFFFFFFFF
               	movl	(%rdx,%rax,4), %edi
               	leaq	-0x70(%rbp), %rcx
               	movl	(%rcx,%rax,4), %r8d
               	negq	%r8
               	cmpl	%r8d, %edi
               	jne	<addr>
               	movslq	(%rsi,%rax,4), %rdi
               	movslq	(%rcx,%rax,4), %rcx
               	xorq	$-0x1, %rcx
               	cmpq	%rcx, %rdi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
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
