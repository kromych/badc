
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
               	subq	$0x118, %rsp            # imm = 0x118
               	pushq	%r12
               	pushq	%rbx
               	leaq	0x10(%rsp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x20(%rsp), %rcx
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	(%rax), %xmm0
               	movups	0x10(%rsp), %xmm1
               	vpcmpgtb	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, 0x30(%rsp)
               	leaq	0x70(%rsp), %rcx
               	xorl	%eax, %eax
               	movl	$0xffffff, 0x70(%rsp)   # imm = 0xFFFFFF
               	movl	$0xffff00, 0x74(%rsp)   # imm = 0xFFFF00
               	movl	$0xff0000ff, 0x78(%rsp) # imm = 0xFF0000FF
               	movl	$0xffffffff, 0x7c(%rsp) # imm = 0xFFFFFFFF
               	leaq	0x40(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rsp), %xmm0
               	movups	0x20(%rsp), %xmm1
               	vpcmpgtb	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, 0x50(%rsp)
               	leaq	0x70(%rsp), %rcx
               	movl	$0xffff0000, 0x70(%rsp) # imm = 0xFFFF0000
               	movl	$0xff00ffff, 0x74(%rsp) # imm = 0xFF00FFFF
               	movq	$-0x1, %rsi
               	xorl	%edi, %edi
               	movl	$0xffffff, 0x78(%rsp)   # imm = 0xFFFFFF
               	movl	$0xff0000, 0x7c(%rsp)   # imm = 0xFF0000
               	leaq	0x60(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rsp), %xmm0
               	movups	0x20(%rsp), %xmm1
               	vpcmpeqb	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, 0x70(%rsp)
               	movsbq	0x30(%rsp,%rax), %r8
               	movsbq	0x20(%rsp,%rax), %r9
               	movsbq	0x10(%rsp,%rax), %r10
               	cmpl	%r9d, %r10d
               	movq	%rdi, %r9
               	cmovlq	%rsi, %r9
               	cmpl	%r9d, %r8d
               	jne	<addr>
               	movsbq	0x40(%rsp,%rax), %r8
               	movsbq	0x20(%rsp,%rax), %r9
               	movq	$-0x1, %rbx
               	xorl	%r12d, %r12d
               	movsbq	0x10(%rsp,%rax), %r10
               	cmpl	%r9d, %r10d
               	cmovgq	%r12, %rbx
               	cmpl	%ebx, %r8d
               	jne	<addr>
               	movsbq	0x50(%rsp,%rax), %r8
               	movsbq	0x20(%rsp,%rax), %r10
               	movq	$-0x1, %r11
               	xorl	%ebx, %ebx
               	movsbq	0x10(%rsp,%rax), %r9
               	cmpl	%r10d, %r9d
               	cmovleq	%rbx, %r11
               	cmpl	%r11d, %r8d
               	jne	<addr>
               	movsbq	0x60(%rsp,%rax), %r8
               	movsbq	0x20(%rsp,%rax), %r10
               	movq	$-0x1, %r11
               	xorl	%ebx, %ebx
               	movsbq	0x10(%rsp,%rax), %r9
               	cmpl	%r10d, %r9d
               	cmovlq	%rbx, %r11
               	cmpl	%r11d, %r8d
               	jne	<addr>
               	movsbq	0x70(%rsp,%rax), %r8
               	movsbq	0x20(%rsp,%rax), %r10
               	movq	$-0x1, %r11
               	xorl	%ebx, %ebx
               	movsbq	0x10(%rsp,%rax), %r9
               	cmpl	%r10d, %r9d
               	cmovneq	%rbx, %r11
               	cmpl	%r11d, %r8d
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x10(%rsp), %rax
               	leaq	0x80(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x20(%rsp), %rax
               	leaq	0x90(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x70(%rsp), %rcx
               	xorl	%eax, %eax
               	movl	$0xff000000, 0x70(%rsp) # imm = 0xFF000000
               	movl	$0xff0000ff, 0x74(%rsp) # imm = 0xFF0000FF
               	movl	$0xff000000, 0x78(%rsp) # imm = 0xFF000000
               	movl	$0xff00ffff, 0x7c(%rsp) # imm = 0xFF00FFFF
               	leaq	0x30(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x70(%rsp), %rcx
               	movl	$0xffff0000, 0x70(%rsp) # imm = 0xFFFF0000
               	movl	$0xff00ffff, 0x74(%rsp) # imm = 0xFF00FFFF
               	movl	$0xff0000ff, 0x78(%rsp) # imm = 0xFF0000FF
               	movl	$0xffffffff, 0x7c(%rsp) # imm = 0xFFFFFFFF
               	leaq	0x40(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x70(%rsp), %rcx
               	movl	$0xffff, 0x70(%rsp)     # imm = 0xFFFF
               	movl	$0xff0000, 0x74(%rsp)   # imm = 0xFF0000
               	movl	$0xffff00, 0x78(%rsp)   # imm = 0xFFFF00
               	movl	$0x0, 0x7c(%rsp)
               	leaq	0x50(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x70(%rsp), %rcx
               	movl	$0xffffff, 0x70(%rsp)   # imm = 0xFFFFFF
               	movl	$0xffff00, 0x74(%rsp)   # imm = 0xFFFF00
               	movl	$0xffffff, 0x78(%rsp)   # imm = 0xFFFFFF
               	xorl	%esi, %esi
               	movq	$-0x1, %rdi
               	movl	$0xff0000, 0x7c(%rsp)   # imm = 0xFF0000
               	leaq	0x60(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x80(%rsp), %xmm0
               	movups	0x90(%rsp), %xmm1
               	vpcmpeqb	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, 0x70(%rsp)
               	movsbq	0x30(%rsp,%rax), %r8
               	movzbq	0x90(%rsp,%rax), %r9
               	movzbq	0x80(%rsp,%rax), %r10
               	cmpl	%r9d, %r10d
               	movq	%rsi, %r9
               	cmovlq	%rdi, %r9
               	cmpl	%r9d, %r8d
               	jne	<addr>
               	movsbq	0x40(%rsp,%rax), %r8
               	movzbq	0x90(%rsp,%rax), %r9
               	movq	$-0x1, %rbx
               	xorl	%r12d, %r12d
               	movzbq	0x80(%rsp,%rax), %r10
               	cmpl	%r9d, %r10d
               	cmovgq	%r12, %rbx
               	cmpl	%ebx, %r8d
               	jne	<addr>
               	movsbq	0x50(%rsp,%rax), %r8
               	movzbq	0x90(%rsp,%rax), %r10
               	movq	$-0x1, %r11
               	xorl	%ebx, %ebx
               	movzbq	0x80(%rsp,%rax), %r9
               	cmpl	%r10d, %r9d
               	cmovleq	%rbx, %r11
               	cmpl	%r11d, %r8d
               	jne	<addr>
               	movsbq	0x60(%rsp,%rax), %r8
               	movzbq	0x90(%rsp,%rax), %r10
               	movq	$-0x1, %r11
               	xorl	%ebx, %ebx
               	movzbq	0x80(%rsp,%rax), %r9
               	cmpl	%r10d, %r9d
               	cmovlq	%rbx, %r11
               	cmpl	%r11d, %r8d
               	jne	<addr>
               	movsbq	0x70(%rsp,%rax), %r8
               	movzbq	0x90(%rsp,%rax), %r10
               	movq	$-0x1, %r11
               	xorl	%ebx, %ebx
               	movzbq	0x80(%rsp,%rax), %r9
               	cmpl	%r10d, %r9d
               	cmovneq	%rbx, %r11
               	cmpl	%r11d, %r8d
               	jne	<addr>
               	incq	%rax
               	nop
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0xd8(%rsp), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	leaq	0xe0(%rsp), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movsd	<rip>, %xmm1
               	movsd	0xd8(%rsp), %xmm0
               	vpcmpgtw	%xmm0, %xmm1, %xmm1
               	movsd	%xmm1, 0xf8(%rsp)
               	xorl	%eax, %eax
               	movl	$0xffffffff, %ecx       # imm = 0xFFFFFFFF
               	movq	%rcx, 0x100(%rsp)
               	movsd	0xe0(%rsp), %xmm1
               	vpcmpgtw	%xmm1, %xmm0, %xmm0
               	movsd	%xmm0, 0x108(%rsp)
               	movq	$-0x10000, 0x110(%rsp)  # imm = 0xFFFF0000
               	movsd	0xd8(%rsp), %xmm0
               	vpcmpeqw	%xmm1, %xmm0, %xmm0
               	movsd	%xmm0, 0x118(%rsp)
               	movswq	0xf8(%rsp,%rax,2), %rdi
               	movswq	0xe0(%rsp,%rax,2), %r8
               	movq	$-0x1, %r9
               	xorl	%ebx, %ebx
               	movswq	0xd8(%rsp,%rax,2), %r10
               	cmpl	%r8d, %r10d
               	cmovgeq	%rbx, %r9
               	cmpl	%r9d, %edi
               	jne	<addr>
               	movswq	0x100(%rsp,%rax,2), %rdi
               	movswq	0xe0(%rsp,%rax,2), %r8
               	movq	$-0x1, %r9
               	xorl	%ebx, %ebx
               	movswq	0xd8(%rsp,%rax,2), %r10
               	cmpl	%r8d, %r10d
               	cmovgq	%rbx, %r9
               	nopw	(%rax,%rax)
               	cmpl	%r9d, %edi
               	jne	<addr>
               	movswq	0x108(%rsp,%rax,2), %rdi
               	movswq	0xe0(%rsp,%rax,2), %r8
               	movq	$-0x1, %r9
               	xorl	%ebx, %ebx
               	movswq	0xd8(%rsp,%rax,2), %r10
               	cmpl	%r8d, %r10d
               	cmovleq	%rbx, %r9
               	cmpl	%r9d, %edi
               	jne	<addr>
               	movswq	0x110(%rsp,%rax,2), %rdi
               	movswq	0xe0(%rsp,%rax,2), %r9
               	movq	$-0x1, %rbx
               	xorl	%r12d, %r12d
               	movswq	0xd8(%rsp,%rax,2), %r8
               	cmpl	%r9d, %r8d
               	cmovlq	%r12, %rbx
               	cmpl	%ebx, %edi
               	jne	<addr>
               	movswq	0x118(%rsp,%rax,2), %rdi
               	movswq	0xe0(%rsp,%rax,2), %r9
               	movq	$-0x1, %rbx
               	xorl	%r12d, %r12d
               	movswq	0xd8(%rsp,%rax,2), %r8
               	cmpl	%r9d, %r8d
               	cmovneq	%r12, %rbx
               	nopl	(%rax)
               	cmpl	%ebx, %edi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	0xd8(%rsp), %rax
               	leaq	0xe8(%rsp), %rcx
               	movq	(%rax), %r10
               	movq	%r10, (%rcx)
               	leaq	0xe0(%rsp), %rax
               	leaq	0xf0(%rsp), %rcx
               	movq	(%rax), %r10
               	movq	%r10, (%rcx)
               	xorl	%eax, %eax
               	movabsq	$0xffff00000000, %rcx   # imm = 0xFFFF00000000
               	movq	%rcx, 0xf8(%rsp)
               	movabsq	$0xffffffff0000, %rcx   # imm = 0xFFFFFFFF0000
               	movq	%rcx, 0x100(%rsp)
               	xorl	%edi, %edi
               	movabsq	$-0xffffffff0001, %rcx  # imm = 0xFFFF00000000FFFF
               	movq	%rcx, 0x108(%rsp)
               	movabsq	$-0xffff00000001, %rcx  # imm = 0xFFFF0000FFFFFFFF
               	movq	%rcx, 0x110(%rsp)
               	movsd	0xe8(%rsp), %xmm0
               	movsd	0xf0(%rsp), %xmm1
               	vpcmpeqw	%xmm1, %xmm0, %xmm0
               	movsd	%xmm0, 0x118(%rsp)
               	movswq	0xf8(%rsp,%rax,2), %r8
               	movzwq	0xf0(%rsp,%rax,2), %r9
               	movq	$-0x1, %r10
               	movzwq	0xe8(%rsp,%rax,2), %r11
               	cmpl	%r9d, %r11d
               	cmovgeq	%rdi, %r10
               	cmpl	%r10d, %r8d
               	jne	<addr>
               	movswq	0x100(%rsp,%rax,2), %r8
               	movzwq	0xf0(%rsp,%rax,2), %r9
               	movq	$-0x1, %rbx
               	xorl	%r12d, %r12d
               	movzwq	0xe8(%rsp,%rax,2), %r10
               	cmpl	%r9d, %r10d
               	cmovgq	%r12, %rbx
               	cmpl	%ebx, %r8d
               	jne	<addr>
               	movswq	0x108(%rsp,%rax,2), %r8
               	movzwq	0xf0(%rsp,%rax,2), %r10
               	movq	$-0x1, %r11
               	xorl	%ebx, %ebx
               	movzwq	0xe8(%rsp,%rax,2), %r9
               	cmpl	%r10d, %r9d
               	cmovleq	%rbx, %r11
               	nopl	(%rax)
               	cmpl	%r11d, %r8d
               	jne	<addr>
               	movswq	0x110(%rsp,%rax,2), %r8
               	movzwq	0xf0(%rsp,%rax,2), %r10
               	movq	$-0x1, %r11
               	xorl	%ebx, %ebx
               	movzwq	0xe8(%rsp,%rax,2), %r9
               	cmpl	%r10d, %r9d
               	cmovlq	%rbx, %r11
               	cmpl	%r11d, %r8d
               	jne	<addr>
               	movswq	0x118(%rsp,%rax,2), %r8
               	movzwq	0xf0(%rsp,%rax,2), %r10
               	movq	$-0x1, %r11
               	xorl	%ebx, %ebx
               	movzwq	0xe8(%rsp,%rax,2), %r9
               	cmpl	%r10d, %r9d
               	cmovneq	%rbx, %r11
               	cmpl	%r11d, %r8d
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	0xa0(%rsp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xb0(%rsp), %rcx
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	(%rax), %xmm1
               	movups	0xa0(%rsp), %xmm0
               	vpcmpgtd	%xmm0, %xmm1, %xmm1
               	movups	%xmm1, 0x30(%rsp)
               	xorl	%eax, %eax
               	movl	$0xffffffff, %ecx       # imm = 0xFFFFFFFF
               	movq	%rcx, 0x40(%rsp)
               	movq	$-0x1, 0x48(%rsp)
               	movups	0xb0(%rsp), %xmm1
               	vpcmpgtd	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, 0x50(%rsp)
               	movabsq	$-0x100000000, %rcx     # imm = 0xFFFFFFFF00000000
               	movq	%rcx, 0x60(%rsp)
               	movq	$-0x1, 0x68(%rsp)
               	movups	0xa0(%rsp), %xmm0
               	vpcmpeqd	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, 0x70(%rsp)
               	movl	0x30(%rsp,%rax,4), %edi
               	movl	0xb0(%rsp,%rax,4), %r8d
               	movq	$-0x1, %r9
               	xorl	%ebx, %ebx
               	movl	0xa0(%rsp,%rax,4), %r10d
               	cmpl	%r8d, %r10d
               	cmovgeq	%rbx, %r9
               	cmpl	%r9d, %edi
               	jne	<addr>
               	movl	0x40(%rsp,%rax,4), %edi
               	movl	0xb0(%rsp,%rax,4), %r8d
               	movq	$-0x1, %r9
               	xorl	%ebx, %ebx
               	movl	0xa0(%rsp,%rax,4), %r10d
               	cmpl	%r8d, %r10d
               	cmovgq	%rbx, %r9
               	nop
               	cmpl	%r9d, %edi
               	jne	<addr>
               	movl	0x50(%rsp,%rax,4), %edi
               	movl	0xb0(%rsp,%rax,4), %r8d
               	movq	$-0x1, %r9
               	xorl	%ebx, %ebx
               	movl	0xa0(%rsp,%rax,4), %r10d
               	cmpl	%r8d, %r10d
               	cmovleq	%rbx, %r9
               	cmpl	%r9d, %edi
               	jne	<addr>
               	movl	0x60(%rsp,%rax,4), %edi
               	movl	0xb0(%rsp,%rax,4), %r9d
               	movq	$-0x1, %rbx
               	xorl	%r12d, %r12d
               	movl	0xa0(%rsp,%rax,4), %r8d
               	cmpl	%r9d, %r8d
               	cmovlq	%r12, %rbx
               	nopl	(%rax,%rax)
               	cmpl	%ebx, %edi
               	jne	<addr>
               	movl	0x70(%rsp,%rax,4), %edi
               	movl	0xb0(%rsp,%rax,4), %r9d
               	movq	$-0x1, %rbx
               	xorl	%r12d, %r12d
               	movl	0xa0(%rsp,%rax,4), %r8d
               	cmpl	%r9d, %r8d
               	cmovneq	%r12, %rbx
               	cmpl	%ebx, %edi
               	jne	<addr>
               	incq	%rax
               	nopl	(%rax,%rax)
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	0xa0(%rsp), %rax
               	leaq	0x20(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0xb0(%rsp), %rax
               	leaq	0x90(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	xorl	%eax, %eax
               	movabsq	$-0x100000000, %rcx     # imm = 0xFFFFFFFF00000000
               	movq	%rcx, 0x30(%rsp)
               	movq	$0x0, 0x38(%rsp)
               	movq	%rcx, 0x40(%rsp)
               	movq	$-0x1, 0x48(%rsp)
               	movl	$0xffffffff, %ecx       # imm = 0xFFFFFFFF
               	xorl	%edi, %edi
               	movq	%rcx, 0x50(%rsp)
               	movq	$0x0, 0x58(%rsp)
               	movq	%rcx, 0x60(%rsp)
               	movq	$-0x1, 0x68(%rsp)
               	movups	0x20(%rsp), %xmm0
               	movups	0x90(%rsp), %xmm1
               	vpcmpeqd	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, 0x70(%rsp)
               	movl	0x30(%rsp,%rax,4), %r8d
               	movl	0x90(%rsp,%rax,4), %r9d
               	movq	$-0x1, %r10
               	movl	0x20(%rsp,%rax,4), %r11d
               	cmpl	%r9d, %r11d
               	cmovaeq	%rdi, %r10
               	nopw	(%rax,%rax)
               	cmpl	%r10d, %r8d
               	jne	<addr>
               	movl	0x40(%rsp,%rax,4), %r8d
               	movl	0x90(%rsp,%rax,4), %r9d
               	movq	$-0x1, %rbx
               	xorl	%r12d, %r12d
               	movl	0x20(%rsp,%rax,4), %r10d
               	cmpl	%r9d, %r10d
               	cmovaq	%r12, %rbx
               	cmpl	%ebx, %r8d
               	jne	<addr>
               	movl	0x50(%rsp,%rax,4), %r8d
               	movl	0x90(%rsp,%rax,4), %r10d
               	movq	$-0x1, %r11
               	xorl	%ebx, %ebx
               	movl	0x20(%rsp,%rax,4), %r9d
               	cmpl	%r10d, %r9d
               	cmovbeq	%rbx, %r11
               	nopw	(%rax,%rax)
               	cmpl	%r11d, %r8d
               	jne	<addr>
               	movl	0x60(%rsp,%rax,4), %r8d
               	movl	0x90(%rsp,%rax,4), %r10d
               	movq	$-0x1, %r11
               	xorl	%ebx, %ebx
               	movl	0x20(%rsp,%rax,4), %r9d
               	cmpl	%r10d, %r9d
               	cmovbq	%rbx, %r11
               	cmpl	%r11d, %r8d
               	jne	<addr>
               	movl	0x70(%rsp,%rax,4), %r8d
               	movl	0x90(%rsp,%rax,4), %r10d
               	movq	$-0x1, %r11
               	xorl	%ebx, %ebx
               	movl	0x20(%rsp,%rax,4), %r9d
               	cmpl	%r10d, %r9d
               	cmovneq	%rbx, %r11
               	cmpl	%r11d, %r8d
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	0xc0(%rsp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xb0(%rsp), %rcx
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	(%rax), %xmm1
               	movups	0xc0(%rsp), %xmm0
               	vpcmpgtq	%xmm0, %xmm1, %xmm1
               	movups	%xmm1, 0x30(%rsp)
               	xorl	%eax, %eax
               	movq	$-0x1, 0x40(%rsp)
               	movq	$-0x1, 0x48(%rsp)
               	movups	0xb0(%rsp), %xmm1
               	vpcmpgtq	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, 0x50(%rsp)
               	movq	%rax, 0x60(%rsp)
               	movq	$-0x1, 0x68(%rsp)
               	movups	0xc0(%rsp), %xmm0
               	vpcmpeqq	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, 0x70(%rsp)
               	movq	0x30(%rsp,%rax,8), %r8
               	movq	0xb0(%rsp,%rax,8), %r9
               	movq	$-0x1, %rbx
               	xorl	%r12d, %r12d
               	movq	0xc0(%rsp,%rax,8), %r10
               	cmpq	%r9, %r10
               	cmovgeq	%r12, %rbx
               	nopw	(%rax,%rax)
               	cmpq	%rbx, %r8
               	jne	<addr>
               	movq	0x40(%rsp,%rax,8), %r8
               	movq	0xb0(%rsp,%rax,8), %r9
               	movq	$-0x1, %rbx
               	xorl	%r12d, %r12d
               	movq	0xc0(%rsp,%rax,8), %r10
               	cmpq	%r9, %r10
               	cmovgq	%r12, %rbx
               	cmpq	%rbx, %r8
               	jne	<addr>
               	movq	0x50(%rsp,%rax,8), %r8
               	movq	0xb0(%rsp,%rax,8), %rdx
               	movq	$-0x1, %r9
               	xorl	%r10d, %r10d
               	movq	0xc0(%rsp,%rax,8), %rcx
               	cmpq	%rdx, %rcx
               	cmovleq	%r10, %r9
               	nop
               	cmpq	%r9, %r8
               	jne	<addr>
               	movq	0x60(%rsp,%rax,8), %r8
               	movq	0xb0(%rsp,%rax,8), %r9
               	movq	$-0x1, %rbx
               	xorl	%r12d, %r12d
               	movq	0xc0(%rsp,%rax,8), %r10
               	cmpq	%r9, %r10
               	cmovlq	%r12, %rbx
               	cmpq	%rbx, %r8
               	jne	<addr>
               	movq	0x70(%rsp,%rax,8), %r8
               	movq	0xb0(%rsp,%rax,8), %rdx
               	movq	$-0x1, %r9
               	xorl	%r10d, %r10d
               	movq	0xc0(%rsp,%rax,8), %rcx
               	cmpq	%rdx, %rcx
               	cmovneq	%r10, %r9
               	nop
               	cmpq	%r9, %r8
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	0xc0(%rsp), %rax
               	leaq	0x20(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0xb0(%rsp), %rax
               	leaq	0x90(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	xorl	%eax, %eax
               	movq	%rax, 0x30(%rsp)
               	movq	%rax, 0x38(%rsp)
               	movq	%rax, 0x40(%rsp)
               	movq	$-0x1, 0x48(%rsp)
               	movq	$-0x1, 0x50(%rsp)
               	movq	%rax, 0x58(%rsp)
               	movq	$-0x1, 0x60(%rsp)
               	movq	$-0x1, 0x68(%rsp)
               	movups	0x20(%rsp), %xmm0
               	movups	0x90(%rsp), %xmm1
               	vpcmpeqq	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, 0x70(%rsp)
               	movq	0x30(%rsp,%rax,8), %r8
               	movq	0x90(%rsp,%rax,8), %r9
               	movq	$-0x1, %rbx
               	xorl	%r12d, %r12d
               	movq	0x20(%rsp,%rax,8), %r10
               	cmpq	%r9, %r10
               	cmovaeq	%r12, %rbx
               	cmpq	%rbx, %r8
               	jne	<addr>
               	movq	0x40(%rsp,%rax,8), %r8
               	movq	0x90(%rsp,%rax,8), %r9
               	movq	$-0x1, %rbx
               	xorl	%r12d, %r12d
               	movq	0x20(%rsp,%rax,8), %r10
               	cmpq	%r9, %r10
               	cmovaq	%r12, %rbx
               	cmpq	%rbx, %r8
               	jne	<addr>
               	movq	0x50(%rsp,%rax,8), %r8
               	movq	0x90(%rsp,%rax,8), %rdx
               	movq	$-0x1, %r9
               	xorl	%r10d, %r10d
               	movq	0x20(%rsp,%rax,8), %rcx
               	cmpq	%rdx, %rcx
               	cmovbeq	%r10, %r9
               	cmpq	%r9, %r8
               	jne	<addr>
               	movq	0x60(%rsp,%rax,8), %r8
               	movq	0x90(%rsp,%rax,8), %r9
               	movq	$-0x1, %rbx
               	xorl	%r12d, %r12d
               	movq	0x20(%rsp,%rax,8), %r10
               	cmpq	%r9, %r10
               	cmovbq	%r12, %rbx
               	nopw	(%rax,%rax)
               	cmpq	%rbx, %r8
               	jne	<addr>
               	movq	0x70(%rsp,%rax,8), %r8
               	movq	0x90(%rsp,%rax,8), %rdx
               	movq	$-0x1, %r9
               	xorl	%r10d, %r10d
               	movq	0x20(%rsp,%rax,8), %rcx
               	cmpq	%rdx, %rcx
               	cmovneq	%r10, %r9
               	cmpq	%r9, %r8
               	jne	<addr>
               	incq	%rax
               	nopl	(%rax,%rax)
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	0x70(%rsp), %rax
               	movl	$0x800f800, 0x70(%rsp)  # imm = 0x800F800
               	movl	$0x18d828f8, 0x74(%rsp) # imm = 0x18D828F8
               	movl	$0x20b84818, 0x78(%rsp) # imm = 0x20B84818
               	movl	$0x403800e0, 0x7c(%rsp) # imm = 0x403800E0
               	leaq	0x40(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x70(%rsp), %rax
               	movl	$0xffe0, 0x70(%rsp)     # imm = 0xFFE0
               	movl	$0xfe011f, 0x74(%rsp)   # imm = 0xFE011F
               	movl	$0x19fd0200, 0x78(%rsp) # imm = 0x19FD0200
               	movl	$0x20100e7, 0x7c(%rsp)  # imm = 0x20100E7
               	leaq	0x50(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x70(%rsp), %rax
               	movl	$0x1f10, 0x70(%rsp)     # imm = 0x1F10
               	movl	$0x1f000f, 0x74(%rsp)   # imm = 0x1F000F
               	movl	$0xc1e0100, 0x78(%rsp)  # imm = 0xC1E0100
               	movl	$0x1000013, 0x7c(%rsp)  # imm = 0x1000013
               	leaq	0x60(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movabsq	$-0x3fda7fffe00000, %rax # imm = 0xFFC0258000200000
               	movq	%rax, 0x110(%rsp)
               	xorl	%eax, %eax
               	movabsq	$-0xffffffff0001, %rcx  # imm = 0xFFFF00000000FFFF
               	movq	%rcx, 0x118(%rsp)
               	movsbq	0x40(%rsp,%rax), %r8
               	movsbq	0x10(%rsp,%rax), %rcx
               	movq	%rcx, %r9
               	shlq	$0x3, %r9
               	movsbq	%r9b, %r9
               	nopl	(%rax)
               	cmpl	%r9d, %r8d
               	jne	<addr>
               	movsbq	0x50(%rsp,%rax), %r8
               	sarq	$0x2, %rcx
               	cmpl	%ecx, %r8d
               	jne	<addr>
               	movzbq	0x60(%rsp,%rax), %r8
               	movzbq	0x80(%rsp,%rax), %rcx
               	shrq	$0x3, %rcx
               	cmpl	%ecx, %r8d
               	jne	<addr>
               	incq	%rax
               	nopl	(%rax,%rax)
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movswq	0x110(%rsp,%rax,2), %rdx
               	movswq	0xd8(%rsp,%rax,2), %rcx
               	movq	%rcx, %r8
               	shlq	$0x5, %r8
               	movswq	%r8w, %r8
               	cmpl	%r8d, %edx
               	jne	<addr>
               	movswq	0x118(%rsp,%rax,2), %rdx
               	sarq	$0xf, %rcx
               	nopw	(%rax,%rax)
               	cmpl	%ecx, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movups	0xa0(%rsp), %xmm0
               	movq	%rax, %xmm14
               	vpsubd	%xmm0, %xmm14, %xmm1
               	movups	%xmm1, 0x50(%rsp)
               	vpcmpeqd	%xmm1, %xmm1, %xmm1
               	vpxor	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, 0x60(%rsp)
               	movups	0xc0(%rsp), %xmm0
               	movq	%rax, %xmm14
               	vpsubq	%xmm0, %xmm14, %xmm0
               	movups	0x80(%rsp), %xmm2
               	vpxor	%xmm1, %xmm2, %xmm1
               	movups	%xmm1, 0x70(%rsp)
               	movl	0x50(%rsp,%rax,4), %r8d
               	movl	0xa0(%rsp,%rax,4), %ecx
               	movq	%rcx, %r9
               	negq	%r9
               	cmpl	%r9d, %r8d
               	jne	<addr>
               	movl	0x60(%rsp,%rax,4), %r8d
               	xorq	$-0x1, %rcx
               	nopl	(%rax,%rax)
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
               	addq	$0x118, %rsp            # imm = 0x118
               	retq
               	movzbq	0x70(%rsp), %rax
               	cmpl	$0x7f, %eax
               	je	<addr>
               	movl	$0xd, %eax
               	popq	%rbx
               	popq	%r12
               	addq	$0x118, %rsp            # imm = 0x118
               	retq
               	cmpb	$0x0, 0x71(%rsp)
               	jne	<addr>
               	movzbq	0x72(%rsp), %rax
               	cmpl	$0xff, %eax
               	jne	<addr>
               	movzbq	0x73(%rsp), %rax
               	cmpl	$0xfe, %eax
               	jne	<addr>
               	movzbq	0x74(%rsp), %rax
               	cmpl	$0x80, %eax
               	jne	<addr>
               	movzbq	0x75(%rsp), %rax
               	cmpl	$0xfa, %eax
               	jne	<addr>
               	movzbq	0x76(%rsp), %rax
               	cmpl	$0x4, %eax
               	jne	<addr>
               	movzbq	0x77(%rsp), %rax
               	cmpl	$0xfc, %eax
               	jne	<addr>
               	movzbq	0x78(%rsp), %rax
               	cmpl	$0xfc, %eax
               	jne	<addr>
               	movzbq	0x79(%rsp), %rax
               	cmpl	$0xf6, %eax
               	jne	<addr>
               	movzbq	0x7a(%rsp), %rax
               	cmpl	$0x8, %eax
               	jne	<addr>
               	movzbq	0x7b(%rsp), %rax
               	cmpl	$0x9b, %eax
               	jne	<addr>
               	movzbq	0x7c(%rsp), %rax
               	cmpl	$0x63, %eax
               	jne	<addr>
               	movzbq	0x7d(%rsp), %rax
               	cmpl	$0xff, %eax
               	jne	<addr>
               	movzbq	0x7e(%rsp), %rax
               	cmpl	$0xf8, %eax
               	jne	<addr>
               	movzbq	0x7f(%rsp), %rax
               	cmpl	$0xf7, %eax
               	jne	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	addq	$0x118, %rsp            # imm = 0x118
               	retq
               	movl	$0xb, %eax
               	popq	%rbx
               	popq	%r12
               	addq	$0x118, %rsp            # imm = 0x118
               	retq
               	movl	$0xa, %eax
               	popq	%rbx
               	popq	%r12
               	addq	$0x118, %rsp            # imm = 0x118
               	retq
               	movl	$0x9, %eax
               	popq	%rbx
               	popq	%r12
               	addq	$0x118, %rsp            # imm = 0x118
               	retq
               	movl	$0x8, %eax
               	popq	%rbx
               	popq	%r12
               	addq	$0x118, %rsp            # imm = 0x118
               	retq
               	movl	$0x7, %eax
               	popq	%rbx
               	popq	%r12
               	addq	$0x118, %rsp            # imm = 0x118
               	retq
               	movl	$0x6, %eax
               	popq	%rbx
               	popq	%r12
               	addq	$0x118, %rsp            # imm = 0x118
               	retq
               	movl	$0x5, %eax
               	popq	%rbx
               	popq	%r12
               	addq	$0x118, %rsp            # imm = 0x118
               	retq
               	movl	$0x4, %eax
               	popq	%rbx
               	popq	%r12
               	addq	$0x118, %rsp            # imm = 0x118
               	retq
               	movl	$0x3, %eax
               	popq	%rbx
               	popq	%r12
               	addq	$0x118, %rsp            # imm = 0x118
               	retq
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	addq	$0x118, %rsp            # imm = 0x118
               	retq
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	addq	$0x118, %rsp            # imm = 0x118
               	retq
