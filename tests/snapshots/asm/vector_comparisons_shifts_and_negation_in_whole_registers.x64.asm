
vector_comparisons_shifts_and_negation_in_whole_registers.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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
               	subq	$0x120, %rsp            # imm = 0x120
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	leaq	0x20(%rsp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x30(%rsp), %rcx
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	(%rax), %xmm0
               	movups	0x20(%rsp), %xmm1
               	vpcmpgtb	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, 0x40(%rsp)
               	leaq	0x80(%rsp), %rcx
               	xorl	%eax, %eax
               	movl	$0xffffff, 0x80(%rsp)   # imm = 0xFFFFFF
               	movl	$0xffff00, 0x84(%rsp)   # imm = 0xFFFF00
               	movl	$0xff0000ff, 0x88(%rsp) # imm = 0xFF0000FF
               	movl	$0xffffffff, 0x8c(%rsp) # imm = 0xFFFFFFFF
               	leaq	0x50(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x20(%rsp), %xmm0
               	movups	0x30(%rsp), %xmm1
               	vpcmpgtb	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, 0x60(%rsp)
               	leaq	0x80(%rsp), %rsi
               	movl	$0xffff0000, 0x80(%rsp) # imm = 0xFFFF0000
               	movl	$0xff00ffff, 0x84(%rsp) # imm = 0xFF00FFFF
               	xorl	%ecx, %ecx
               	movl	$0xffffff, 0x88(%rsp)   # imm = 0xFFFFFF
               	movq	$-0x1, %rdx
               	movl	$0xff0000, 0x8c(%rsp)   # imm = 0xFF0000
               	leaq	0x70(%rsp), %rdi
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x20(%rsp), %xmm0
               	movups	0x30(%rsp), %xmm1
               	vpcmpeqb	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, 0x80(%rsp)
               	movsbq	0x40(%rsp,%rax), %r8
               	movsbq	0x30(%rsp,%rax), %r9
               	movsbq	0x20(%rsp,%rax), %rbx
               	cmpl	%r9d, %ebx
               	movq	%rcx, %r9
               	cmovlq	%rdx, %r9
               	cmpl	%r9d, %r8d
               	jne	<addr>
               	movsbq	0x50(%rsp,%rax), %r8
               	movsbq	0x30(%rsp,%rax), %rbx
               	movq	$-0x1, %r12
               	xorl	%r13d, %r13d
               	movsbq	0x20(%rsp,%rax), %r9
               	cmpl	%ebx, %r9d
               	cmovgq	%r13, %r12
               	cmpl	%r12d, %r8d
               	jne	<addr>
               	movsbq	0x60(%rsp,%rax), %r8
               	movsbq	0x30(%rsp,%rax), %rbx
               	movq	$-0x1, %r12
               	xorl	%r13d, %r13d
               	movsbq	0x20(%rsp,%rax), %r9
               	cmpl	%ebx, %r9d
               	cmovleq	%r13, %r12
               	cmpl	%r12d, %r8d
               	jne	<addr>
               	movsbq	0x70(%rsp,%rax), %r8
               	movsbq	0x30(%rsp,%rax), %rbx
               	movq	$-0x1, %r12
               	xorl	%r13d, %r13d
               	movsbq	0x20(%rsp,%rax), %r9
               	cmpl	%ebx, %r9d
               	cmovlq	%r13, %r12
               	cmpl	%r12d, %r8d
               	jne	<addr>
               	movsbq	0x80(%rsp,%rax), %r8
               	movsbq	0x30(%rsp,%rax), %rbx
               	movq	$-0x1, %r12
               	xorl	%r13d, %r13d
               	movsbq	0x20(%rsp,%rax), %r9
               	cmpl	%ebx, %r9d
               	cmovneq	%r13, %r12
               	cmpl	%r12d, %r8d
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x20(%rsp), %rax
               	leaq	0x90(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x30(%rsp), %rax
               	leaq	0xa0(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x80(%rsp), %rcx
               	xorl	%eax, %eax
               	movl	$0xff000000, 0x80(%rsp) # imm = 0xFF000000
               	movl	$0xff0000ff, 0x84(%rsp) # imm = 0xFF0000FF
               	movl	$0xff000000, 0x88(%rsp) # imm = 0xFF000000
               	movl	$0xff00ffff, 0x8c(%rsp) # imm = 0xFF00FFFF
               	leaq	0x40(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x80(%rsp), %rcx
               	movl	$0xffff0000, 0x80(%rsp) # imm = 0xFFFF0000
               	movl	$0xff00ffff, 0x84(%rsp) # imm = 0xFF00FFFF
               	movl	$0xff0000ff, 0x88(%rsp) # imm = 0xFF0000FF
               	movl	$0xffffffff, 0x8c(%rsp) # imm = 0xFFFFFFFF
               	leaq	0x50(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x80(%rsp), %rcx
               	movl	$0xffff, 0x80(%rsp)     # imm = 0xFFFF
               	movl	$0xff0000, 0x84(%rsp)   # imm = 0xFF0000
               	movl	$0xffff00, 0x88(%rsp)   # imm = 0xFFFF00
               	movl	$0x0, 0x8c(%rsp)
               	leaq	0x60(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x80(%rsp), %rsi
               	movl	$0xffffff, 0x80(%rsp)   # imm = 0xFFFFFF
               	movl	$0xffff00, 0x84(%rsp)   # imm = 0xFFFF00
               	movl	$0xffffff, 0x88(%rsp)   # imm = 0xFFFFFF
               	xorl	%ecx, %ecx
               	movq	$-0x1, %rdx
               	movl	$0xff0000, 0x8c(%rsp)   # imm = 0xFF0000
               	leaq	0x70(%rsp), %rdi
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x90(%rsp), %xmm0
               	movups	0xa0(%rsp), %xmm1
               	vpcmpeqb	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, 0x80(%rsp)
               	movsbq	0x40(%rsp,%rax), %r8
               	movzbq	0xa0(%rsp,%rax), %r9
               	movzbq	0x90(%rsp,%rax), %rbx
               	cmpl	%r9d, %ebx
               	movq	%rcx, %r9
               	cmovlq	%rdx, %r9
               	cmpl	%r9d, %r8d
               	jne	<addr>
               	movsbq	0x50(%rsp,%rax), %r8
               	movzbq	0xa0(%rsp,%rax), %rbx
               	movq	$-0x1, %r12
               	xorl	%r13d, %r13d
               	movzbq	0x90(%rsp,%rax), %r9
               	cmpl	%ebx, %r9d
               	cmovgq	%r13, %r12
               	cmpl	%r12d, %r8d
               	jne	<addr>
               	movsbq	0x60(%rsp,%rax), %r8
               	movzbq	0xa0(%rsp,%rax), %rbx
               	movq	$-0x1, %r12
               	xorl	%r13d, %r13d
               	movzbq	0x90(%rsp,%rax), %r9
               	cmpl	%ebx, %r9d
               	cmovleq	%r13, %r12
               	cmpl	%r12d, %r8d
               	jne	<addr>
               	movsbq	0x70(%rsp,%rax), %r8
               	movzbq	0xa0(%rsp,%rax), %rbx
               	movq	$-0x1, %r12
               	xorl	%r13d, %r13d
               	movzbq	0x90(%rsp,%rax), %r9
               	cmpl	%ebx, %r9d
               	cmovlq	%r13, %r12
               	cmpl	%r12d, %r8d
               	jne	<addr>
               	movsbq	0x80(%rsp,%rax), %r8
               	movzbq	0xa0(%rsp,%rax), %rbx
               	movq	$-0x1, %r12
               	xorl	%r13d, %r13d
               	movzbq	0x90(%rsp,%rax), %r9
               	cmpl	%ebx, %r9d
               	cmovneq	%r13, %r12
               	cmpl	%r12d, %r8d
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0xe8(%rsp), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	leaq	0xf0(%rsp), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movsd	<rip>, %xmm1
               	movsd	0xe8(%rsp), %xmm0
               	vpcmpgtw	%xmm0, %xmm1, %xmm1
               	movsd	%xmm1, 0x108(%rsp)
               	xorl	%eax, %eax
               	movl	$0xffffffff, %ecx       # imm = 0xFFFFFFFF
               	movq	%rcx, 0x110(%rsp)
               	movsd	0xf0(%rsp), %xmm1
               	vpcmpgtw	%xmm1, %xmm0, %xmm0
               	movsd	%xmm0, 0x118(%rsp)
               	xorl	%edx, %edx
               	movq	$-0x10000, 0x120(%rsp)  # imm = 0xFFFF0000
               	movsd	0xe8(%rsp), %xmm0
               	vpcmpeqw	%xmm1, %xmm0, %xmm0
               	movsd	%xmm0, 0x128(%rsp)
               	movswq	0x108(%rsp,%rax,2), %rdi
               	movswq	0xf0(%rsp,%rax,2), %r8
               	movq	$-0x1, %r9
               	movswq	0xe8(%rsp,%rax,2), %rbx
               	cmpl	%r8d, %ebx
               	cmovgeq	%rdx, %r9
               	cmpl	%r9d, %edi
               	jne	<addr>
               	movswq	0x110(%rsp,%rax,2), %rdi
               	movswq	0xf0(%rsp,%rax,2), %r8
               	movq	$-0x1, %r9
               	xorl	%ebx, %ebx
               	movswq	0xe8(%rsp,%rax,2), %r12
               	cmpl	%r8d, %r12d
               	cmovgq	%rbx, %r9
               	cmpl	%r9d, %edi
               	jne	<addr>
               	movswq	0x118(%rsp,%rax,2), %rdi
               	movswq	0xf0(%rsp,%rax,2), %r9
               	movq	$-0x1, %rbx
               	xorl	%r12d, %r12d
               	movswq	0xe8(%rsp,%rax,2), %r8
               	cmpl	%r9d, %r8d
               	cmovleq	%r12, %rbx
               	cmpl	%ebx, %edi
               	jne	<addr>
               	movswq	0x120(%rsp,%rax,2), %rdi
               	movswq	0xf0(%rsp,%rax,2), %r9
               	movq	$-0x1, %rbx
               	xorl	%r12d, %r12d
               	movswq	0xe8(%rsp,%rax,2), %r8
               	cmpl	%r9d, %r8d
               	cmovlq	%r12, %rbx
               	cmpl	%ebx, %edi
               	jne	<addr>
               	movswq	0x128(%rsp,%rax,2), %rdi
               	movswq	0xf0(%rsp,%rax,2), %r9
               	movq	$-0x1, %rbx
               	xorl	%r12d, %r12d
               	movswq	0xe8(%rsp,%rax,2), %r8
               	cmpl	%r9d, %r8d
               	cmovneq	%r12, %rbx
               	cmpl	%ebx, %edi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	0xe8(%rsp), %rax
               	leaq	0xf8(%rsp), %rcx
               	movq	(%rax), %r10
               	movq	%r10, (%rcx)
               	leaq	0xf0(%rsp), %rax
               	leaq	0x100(%rsp), %rcx
               	movq	(%rax), %r10
               	movq	%r10, (%rcx)
               	xorl	%eax, %eax
               	movabsq	$0xffff00000000, %rcx   # imm = 0xFFFF00000000
               	movq	%rcx, 0x108(%rsp)
               	movabsq	$0xffffffff0000, %rcx   # imm = 0xFFFFFFFF0000
               	movq	%rcx, 0x110(%rsp)
               	movabsq	$-0xffffffff0001, %rcx  # imm = 0xFFFF00000000FFFF
               	movq	%rcx, 0x118(%rsp)
               	movabsq	$-0xffff00000001, %rcx  # imm = 0xFFFF0000FFFFFFFF
               	movq	%rcx, 0x120(%rsp)
               	movsd	0xf8(%rsp), %xmm0
               	movsd	0x100(%rsp), %xmm1
               	vpcmpeqw	%xmm1, %xmm0, %xmm0
               	movsd	%xmm0, 0x128(%rsp)
               	movswq	0x108(%rsp,%rax,2), %rsi
               	movzwq	0x100(%rsp,%rax,2), %rdi
               	movq	$-0x1, %r8
               	xorl	%r9d, %r9d
               	movzwq	0xf8(%rsp,%rax,2), %rbx
               	cmpl	%edi, %ebx
               	cmovgeq	%r9, %r8
               	cmpl	%r8d, %esi
               	jne	<addr>
               	movswq	0x110(%rsp,%rax,2), %rsi
               	movzwq	0x100(%rsp,%rax,2), %rdi
               	movq	$-0x1, %r8
               	xorl	%r9d, %r9d
               	movzwq	0xf8(%rsp,%rax,2), %rbx
               	cmpl	%edi, %ebx
               	cmovgq	%r9, %r8
               	cmpl	%r8d, %esi
               	jne	<addr>
               	movswq	0x118(%rsp,%rax,2), %rsi
               	movzwq	0x100(%rsp,%rax,2), %r8
               	movq	$-0x1, %r9
               	xorl	%ebx, %ebx
               	movzwq	0xf8(%rsp,%rax,2), %rdi
               	cmpl	%r8d, %edi
               	cmovleq	%rbx, %r9
               	cmpl	%r9d, %esi
               	jne	<addr>
               	movswq	0x120(%rsp,%rax,2), %rsi
               	movzwq	0x100(%rsp,%rax,2), %r8
               	movq	$-0x1, %r9
               	xorl	%ebx, %ebx
               	movzwq	0xf8(%rsp,%rax,2), %rdi
               	cmpl	%r8d, %edi
               	cmovlq	%rbx, %r9
               	cmpl	%r9d, %esi
               	jne	<addr>
               	movswq	0x128(%rsp,%rax,2), %rsi
               	movzwq	0x100(%rsp,%rax,2), %r8
               	movq	$-0x1, %r9
               	xorl	%ebx, %ebx
               	movzwq	0xf8(%rsp,%rax,2), %rdi
               	cmpl	%r8d, %edi
               	cmovneq	%rbx, %r9
               	cmpl	%r9d, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	0xb0(%rsp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xc0(%rsp), %rcx
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	(%rax), %xmm1
               	movups	0xb0(%rsp), %xmm0
               	vpcmpgtd	%xmm0, %xmm1, %xmm1
               	movups	%xmm1, 0x40(%rsp)
               	xorl	%eax, %eax
               	movl	$0xffffffff, %ecx       # imm = 0xFFFFFFFF
               	movq	%rcx, 0x50(%rsp)
               	movq	$-0x1, 0x58(%rsp)
               	movups	0xc0(%rsp), %xmm1
               	vpcmpgtd	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, 0x60(%rsp)
               	xorl	%edx, %edx
               	movabsq	$-0x100000000, %rcx     # imm = 0xFFFFFFFF00000000
               	movq	%rcx, 0x70(%rsp)
               	movq	$-0x1, 0x78(%rsp)
               	movups	0xb0(%rsp), %xmm0
               	vpcmpeqd	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, 0x80(%rsp)
               	movl	0x40(%rsp,%rax,4), %edi
               	movl	0xc0(%rsp,%rax,4), %r8d
               	movq	$-0x1, %r9
               	movl	0xb0(%rsp,%rax,4), %ebx
               	cmpl	%r8d, %ebx
               	cmovgeq	%rdx, %r9
               	cmpl	%r9d, %edi
               	jne	<addr>
               	movl	0x50(%rsp,%rax,4), %edi
               	movl	0xc0(%rsp,%rax,4), %r8d
               	movq	$-0x1, %r9
               	xorl	%ebx, %ebx
               	movl	0xb0(%rsp,%rax,4), %r12d
               	cmpl	%r8d, %r12d
               	cmovgq	%rbx, %r9
               	cmpl	%r9d, %edi
               	jne	<addr>
               	movl	0x60(%rsp,%rax,4), %edi
               	movl	0xc0(%rsp,%rax,4), %r9d
               	movq	$-0x1, %rbx
               	xorl	%r12d, %r12d
               	movl	0xb0(%rsp,%rax,4), %r8d
               	cmpl	%r9d, %r8d
               	cmovleq	%r12, %rbx
               	cmpl	%ebx, %edi
               	jne	<addr>
               	movl	0x70(%rsp,%rax,4), %edi
               	movl	0xc0(%rsp,%rax,4), %r9d
               	movq	$-0x1, %rbx
               	xorl	%r12d, %r12d
               	movl	0xb0(%rsp,%rax,4), %r8d
               	cmpl	%r9d, %r8d
               	cmovlq	%r12, %rbx
               	cmpl	%ebx, %edi
               	jne	<addr>
               	movl	0x80(%rsp,%rax,4), %edi
               	movl	0xc0(%rsp,%rax,4), %r9d
               	movq	$-0x1, %rbx
               	xorl	%r12d, %r12d
               	movl	0xb0(%rsp,%rax,4), %r8d
               	cmpl	%r9d, %r8d
               	cmovneq	%r12, %rbx
               	cmpl	%ebx, %edi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	0xb0(%rsp), %rax
               	leaq	0x30(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0xc0(%rsp), %rax
               	leaq	0xa0(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	xorl	%eax, %eax
               	movabsq	$-0x100000000, %rcx     # imm = 0xFFFFFFFF00000000
               	movq	%rcx, 0x40(%rsp)
               	movq	$0x0, 0x48(%rsp)
               	movq	%rcx, 0x50(%rsp)
               	movq	$-0x1, 0x58(%rsp)
               	movl	$0xffffffff, %ecx       # imm = 0xFFFFFFFF
               	movq	%rcx, 0x60(%rsp)
               	movq	$0x0, 0x68(%rsp)
               	movq	%rcx, 0x70(%rsp)
               	movq	$-0x1, 0x78(%rsp)
               	movups	0x30(%rsp), %xmm0
               	movups	0xa0(%rsp), %xmm1
               	vpcmpeqd	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, 0x80(%rsp)
               	movl	0x40(%rsp,%rax,4), %esi
               	movl	0xa0(%rsp,%rax,4), %edi
               	movq	$-0x1, %r8
               	xorl	%r9d, %r9d
               	movl	0x30(%rsp,%rax,4), %ebx
               	cmpl	%edi, %ebx
               	cmovaeq	%r9, %r8
               	cmpl	%r8d, %esi
               	jne	<addr>
               	movl	0x50(%rsp,%rax,4), %esi
               	movl	0xa0(%rsp,%rax,4), %edi
               	movq	$-0x1, %r8
               	xorl	%r9d, %r9d
               	movl	0x30(%rsp,%rax,4), %ebx
               	cmpl	%edi, %ebx
               	cmovaq	%r9, %r8
               	cmpl	%r8d, %esi
               	jne	<addr>
               	movl	0x60(%rsp,%rax,4), %esi
               	movl	0xa0(%rsp,%rax,4), %r8d
               	movq	$-0x1, %r9
               	xorl	%ebx, %ebx
               	movl	0x30(%rsp,%rax,4), %edi
               	cmpl	%r8d, %edi
               	cmovbeq	%rbx, %r9
               	cmpl	%r9d, %esi
               	jne	<addr>
               	movl	0x70(%rsp,%rax,4), %esi
               	movl	0xa0(%rsp,%rax,4), %r8d
               	movq	$-0x1, %r9
               	xorl	%ebx, %ebx
               	movl	0x30(%rsp,%rax,4), %edi
               	cmpl	%r8d, %edi
               	cmovbq	%rbx, %r9
               	cmpl	%r9d, %esi
               	jne	<addr>
               	movl	0x80(%rsp,%rax,4), %esi
               	movl	0xa0(%rsp,%rax,4), %r8d
               	movq	$-0x1, %r9
               	xorl	%ebx, %ebx
               	movl	0x30(%rsp,%rax,4), %edi
               	cmpl	%r8d, %edi
               	cmovneq	%rbx, %r9
               	cmpl	%r9d, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	0xd0(%rsp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xc0(%rsp), %rcx
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	(%rax), %xmm1
               	movups	0xd0(%rsp), %xmm0
               	vpcmpgtq	%xmm0, %xmm1, %xmm1
               	movups	%xmm1, 0x40(%rsp)
               	xorl	%eax, %eax
               	movq	$-0x1, 0x50(%rsp)
               	movq	$-0x1, 0x58(%rsp)
               	movups	0xc0(%rsp), %xmm1
               	vpcmpgtq	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, 0x60(%rsp)
               	movq	%rax, 0x70(%rsp)
               	movq	$-0x1, 0x78(%rsp)
               	movups	0xd0(%rsp), %xmm0
               	vpcmpeqq	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, 0x80(%rsp)
               	movq	0x40(%rsp,%rax,8), %rsi
               	movq	0xc0(%rsp,%rax,8), %rdi
               	movq	$-0x1, %r8
               	xorl	%r9d, %r9d
               	movq	0xd0(%rsp,%rax,8), %rbx
               	cmpq	%rdi, %rbx
               	cmovgeq	%r9, %r8
               	cmpq	%r8, %rsi
               	jne	<addr>
               	movq	0x50(%rsp,%rax,8), %rsi
               	movq	0xc0(%rsp,%rax,8), %rdi
               	movq	$-0x1, %r8
               	xorl	%r9d, %r9d
               	movq	0xd0(%rsp,%rax,8), %rbx
               	cmpq	%rdi, %rbx
               	cmovgq	%r9, %r8
               	cmpq	%r8, %rsi
               	jne	<addr>
               	movq	0x60(%rsp,%rax,8), %rsi
               	movq	0xc0(%rsp,%rax,8), %r8
               	movq	$-0x1, %r9
               	xorl	%ebx, %ebx
               	movq	0xd0(%rsp,%rax,8), %rdi
               	cmpq	%r8, %rdi
               	cmovleq	%rbx, %r9
               	cmpq	%r9, %rsi
               	jne	<addr>
               	movq	0x70(%rsp,%rax,8), %rsi
               	movq	0xc0(%rsp,%rax,8), %r8
               	movq	$-0x1, %r9
               	xorl	%ebx, %ebx
               	movq	0xd0(%rsp,%rax,8), %rdi
               	cmpq	%r8, %rdi
               	cmovlq	%rbx, %r9
               	cmpq	%r9, %rsi
               	jne	<addr>
               	movq	0x80(%rsp,%rax,8), %rsi
               	movq	0xc0(%rsp,%rax,8), %r8
               	movq	$-0x1, %r9
               	xorl	%ebx, %ebx
               	movq	0xd0(%rsp,%rax,8), %rdi
               	cmpq	%r8, %rdi
               	cmovneq	%rbx, %r9
               	cmpq	%r9, %rsi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	0xd0(%rsp), %rax
               	leaq	0x30(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0xc0(%rsp), %rax
               	leaq	0xa0(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	xorl	%eax, %eax
               	movq	%rax, 0x40(%rsp)
               	movq	%rax, 0x48(%rsp)
               	movq	%rax, 0x50(%rsp)
               	movq	$-0x1, 0x58(%rsp)
               	movq	$-0x1, 0x60(%rsp)
               	movq	%rax, 0x68(%rsp)
               	movq	$-0x1, 0x70(%rsp)
               	movq	$-0x1, 0x78(%rsp)
               	movups	0x30(%rsp), %xmm0
               	movups	0xa0(%rsp), %xmm1
               	vpcmpeqq	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, 0x80(%rsp)
               	movq	0x40(%rsp,%rax,8), %rsi
               	movq	0xa0(%rsp,%rax,8), %rdi
               	movq	$-0x1, %r8
               	xorl	%r9d, %r9d
               	movq	0x30(%rsp,%rax,8), %rbx
               	cmpq	%rdi, %rbx
               	cmovaeq	%r9, %r8
               	cmpq	%r8, %rsi
               	jne	<addr>
               	movq	0x50(%rsp,%rax,8), %rsi
               	movq	0xa0(%rsp,%rax,8), %rdi
               	movq	$-0x1, %r8
               	xorl	%r9d, %r9d
               	movq	0x30(%rsp,%rax,8), %rbx
               	cmpq	%rdi, %rbx
               	cmovaq	%r9, %r8
               	cmpq	%r8, %rsi
               	jne	<addr>
               	movq	0x60(%rsp,%rax,8), %rsi
               	movq	0xa0(%rsp,%rax,8), %r8
               	movq	$-0x1, %r9
               	xorl	%ebx, %ebx
               	movq	0x30(%rsp,%rax,8), %rdi
               	cmpq	%r8, %rdi
               	cmovbeq	%rbx, %r9
               	cmpq	%r9, %rsi
               	jne	<addr>
               	movq	0x70(%rsp,%rax,8), %rsi
               	movq	0xa0(%rsp,%rax,8), %r8
               	movq	$-0x1, %r9
               	xorl	%ebx, %ebx
               	movq	0x30(%rsp,%rax,8), %rdi
               	cmpq	%r8, %rdi
               	cmovbq	%rbx, %r9
               	cmpq	%r9, %rsi
               	jne	<addr>
               	movq	0x80(%rsp,%rax,8), %rsi
               	movq	0xa0(%rsp,%rax,8), %r8
               	movq	$-0x1, %r9
               	xorl	%ebx, %ebx
               	movq	0x30(%rsp,%rax,8), %rdi
               	cmpq	%r8, %rdi
               	cmovneq	%rbx, %r9
               	cmpq	%r9, %rsi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	0x80(%rsp), %rax
               	movl	$0x800f800, 0x80(%rsp)  # imm = 0x800F800
               	movl	$0x18d828f8, 0x84(%rsp) # imm = 0x18D828F8
               	movl	$0x20b84818, 0x88(%rsp) # imm = 0x20B84818
               	movl	$0x403800e0, 0x8c(%rsp) # imm = 0x403800E0
               	leaq	0x50(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x80(%rsp), %rax
               	movl	$0xffe0, 0x80(%rsp)     # imm = 0xFFE0
               	movl	$0xfe011f, 0x84(%rsp)   # imm = 0xFE011F
               	movl	$0x19fd0200, 0x88(%rsp) # imm = 0x19FD0200
               	movl	$0x20100e7, 0x8c(%rsp)  # imm = 0x20100E7
               	leaq	0x60(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x80(%rsp), %rax
               	movl	$0x1f10, 0x80(%rsp)     # imm = 0x1F10
               	movl	$0x1f000f, 0x84(%rsp)   # imm = 0x1F000F
               	movl	$0xc1e0100, 0x88(%rsp)  # imm = 0xC1E0100
               	movl	$0x1000013, 0x8c(%rsp)  # imm = 0x1000013
               	leaq	0x70(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movabsq	$-0x3fda7fffe00000, %rax # imm = 0xFFC0258000200000
               	movq	%rax, 0x120(%rsp)
               	movabsq	$-0xffffffff0001, %rax  # imm = 0xFFFF00000000FFFF
               	movq	%rax, 0x128(%rsp)
               	xorl	%eax, %eax
               	movsbq	0x50(%rsp,%rax), %r8
               	movsbq	0x20(%rsp,%rax), %rcx
               	movq	%rcx, %r9
               	shlq	$0x3, %r9
               	movsbq	%r9b, %r9
               	cmpl	%r9d, %r8d
               	jne	<addr>
               	movsbq	0x60(%rsp,%rax), %r8
               	sarq	$0x2, %rcx
               	cmpl	%ecx, %r8d
               	jne	<addr>
               	movzbq	0x70(%rsp,%rax), %rcx
               	movzbq	0x90(%rsp,%rax), %r8
               	shrq	$0x3, %r8
               	cmpl	%r8d, %ecx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movswq	0x120(%rsp,%rax,2), %rdx
               	movswq	0xe8(%rsp,%rax,2), %rcx
               	movq	%rcx, %r8
               	shlq	$0x5, %r8
               	movswq	%r8w, %r8
               	cmpl	%r8d, %edx
               	jne	<addr>
               	movswq	0x128(%rsp,%rax,2), %rdx
               	sarq	$0xf, %rcx
               	cmpl	%ecx, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movups	0xb0(%rsp), %xmm0
               	movq	%rax, %xmm14
               	vpsubd	%xmm0, %xmm14, %xmm1
               	movups	%xmm1, 0x60(%rsp)
               	vpcmpeqd	%xmm1, %xmm1, %xmm1
               	vpxor	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, 0x70(%rsp)
               	movups	0xd0(%rsp), %xmm0
               	movq	%rax, %xmm14
               	vpsubq	%xmm0, %xmm14, %xmm0
               	movups	0x90(%rsp), %xmm2
               	vpxor	%xmm1, %xmm2, %xmm1
               	movups	%xmm1, 0x80(%rsp)
               	movl	0x60(%rsp,%rax,4), %r8d
               	movl	0xb0(%rsp,%rax,4), %ecx
               	movq	%rcx, %r9
               	negq	%r9
               	cmpl	%r9d, %r8d
               	jne	<addr>
               	movl	0x70(%rsp,%rax,4), %r8d
               	xorq	$-0x1, %rcx
               	cmpl	%ecx, %r8d
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
               	addq	$0x120, %rsp            # imm = 0x120
               	retq
               	movzbq	0x80(%rsp), %rax
               	cmpl	$0x7f, %eax
               	je	<addr>
               	movl	$0xd, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	addq	$0x120, %rsp            # imm = 0x120
               	retq
               	cmpb	$0x0, 0x81(%rsp)
               	jne	<addr>
               	movzbq	0x82(%rsp), %rax
               	cmpl	$0xff, %eax
               	jne	<addr>
               	movzbq	0x83(%rsp), %rax
               	cmpl	$0xfe, %eax
               	jne	<addr>
               	movzbq	0x84(%rsp), %rax
               	cmpl	$0x80, %eax
               	jne	<addr>
               	movzbq	0x85(%rsp), %rax
               	cmpl	$0xfa, %eax
               	jne	<addr>
               	movzbq	0x86(%rsp), %rax
               	cmpl	$0x4, %eax
               	jne	<addr>
               	movzbq	0x87(%rsp), %rax
               	cmpl	$0xfc, %eax
               	jne	<addr>
               	movzbq	0x88(%rsp), %rax
               	cmpl	$0xfc, %eax
               	jne	<addr>
               	movzbq	0x89(%rsp), %rax
               	cmpl	$0xf6, %eax
               	jne	<addr>
               	movzbq	0x8a(%rsp), %rax
               	cmpl	$0x8, %eax
               	jne	<addr>
               	movzbq	0x8b(%rsp), %rax
               	cmpl	$0x9b, %eax
               	jne	<addr>
               	movzbq	0x8c(%rsp), %rax
               	cmpl	$0x63, %eax
               	jne	<addr>
               	movzbq	0x8d(%rsp), %rax
               	cmpl	$0xff, %eax
               	jne	<addr>
               	movzbq	0x8e(%rsp), %rax
               	cmpl	$0xf8, %eax
               	jne	<addr>
               	movzbq	0x8f(%rsp), %rax
               	cmpl	$0xf7, %eax
               	jne	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	addq	$0x120, %rsp            # imm = 0x120
               	retq
               	movl	$0xb, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	addq	$0x120, %rsp            # imm = 0x120
               	retq
               	movl	$0xa, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	addq	$0x120, %rsp            # imm = 0x120
               	retq
               	movl	$0x9, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	addq	$0x120, %rsp            # imm = 0x120
               	retq
               	movl	$0x8, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	addq	$0x120, %rsp            # imm = 0x120
               	retq
               	movl	$0x7, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	addq	$0x120, %rsp            # imm = 0x120
               	retq
               	movl	$0x6, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	addq	$0x120, %rsp            # imm = 0x120
               	retq
               	movl	$0x5, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	addq	$0x120, %rsp            # imm = 0x120
               	retq
               	movl	$0x4, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	addq	$0x120, %rsp            # imm = 0x120
               	retq
               	movl	$0x3, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	addq	$0x120, %rsp            # imm = 0x120
               	retq
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	addq	$0x120, %rsp            # imm = 0x120
               	retq
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	addq	$0x120, %rsp            # imm = 0x120
               	retq
