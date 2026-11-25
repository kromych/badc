
frame_slots_without_a_red_zone.x64:	file format elf64-x86-64

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

<divs>:
               	subq	$0x20, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rcx, %rbx
               	leaq	(%rdi,%rdi,2), %rax
               	addq	%rsi, %rax
               	leaq	(%rdx,%rdx,4), %rcx
               	addq	%rbx, %rcx
               	imulq	$0x7, %r8, %r12
               	addq	%r9, %r12
               	xorq	%rdi, %rdx
               	xorq	%rbx, %rsi
               	xorq	%r8, %r9
               	leaq	(%rax,%rcx), %r8
               	movq	%r12, %rdi
               	orq	$0x1, %rdi
               	movq	%rax, 0x20(%rsp)
               	movq	%rdx, 0x28(%rsp)
               	movq	%r8, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rbx
               	movq	0x28(%rsp), %rdx
               	movq	0x20(%rsp), %rax
               	movq	%rax, %r8
               	imulq	%rcx, %r8
               	movq	%rax, 0x20(%rsp)
               	movq	%rdx, 0x28(%rsp)
               	movq	%r8, %rax
               	cqto
               	idivq	%rdi
               	movq	%rdx, %rdi
               	movq	0x28(%rsp), %rdx
               	movq	0x20(%rsp), %rax
               	imulq	$0x3d1, %r8, %r8        # imm = 0x3D1
               	movq	%rsi, %r13
               	orq	$0x1, %r13
               	movq	%rax, 0x20(%rsp)
               	movq	%rdx, 0x28(%rsp)
               	movq	%r8, %rax
               	xorl	%edx, %edx
               	divq	%r13
               	movq	%rax, %r8
               	movq	0x28(%rsp), %rdx
               	movq	0x20(%rsp), %rax
               	addq	%rbx, %rdi
               	addq	%r8, %rdi
               	addq	%rdi, %rax
               	addq	%rcx, %rax
               	addq	%r12, %rax
               	addq	%rdx, %rax
               	addq	%rsi, %rax
               	addq	%r9, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	addq	$0x20, %rsp
               	retq

<shifts>:
               	pushq	%rbx
               	leaq	(%rdi,%rdi,4), %rax
               	leaq	(%rsi,%rsi,8), %r8
               	movq	%rdi, %r9
               	xorq	%rsi, %r9
               	addq	%rdi, %rsi
               	movq	%rdx, %rdi
               	andq	$0x3f, %rdi
               	shlxq	%rdi, %rax, %rdi
               	movq	%rcx, %rbx
               	andq	$0x3f, %rbx
               	shrxq	%rbx, %r8, %rbx
               	addq	%rdx, %rcx
               	andq	$0x3f, %rcx
               	shlxq	%rcx, %r9, %rcx
               	leaq	(%rdi,%rbx), %rdx
               	addq	%rdx, %rcx
               	addq	%rcx, %rax
               	addq	%r8, %rax
               	addq	%r9, %rax
               	addq	%rsi, %rax
               	popq	%rbx
               	retq

<widen>:
               	subq	$0x18, %rsp
               	fldt	(%rdi)
               	fstpl	(%rsp)
               	movsd	(%rsp), %xmm0
               	addq	$0x18, %rsp
               	retq

<narrow>:
               	subq	$0x18, %rsp
               	movsd	%xmm0, (%rsp)
               	fldl	(%rsp)
               	fstpt	(%rdi)
               	addq	$0x18, %rsp
               	retq

<main>:
               	subq	$0x28, %rsp
               	movq	<rip>, %rdi # <addr>
               	movq	<rip>, %rsi # <addr>
               	movq	<rip>, %rdx # <addr>
               	movq	<rip>, %rcx # <addr>
               	movq	<rip>, %r8 # <addr>
               	movq	<rip>, %r9 # <addr>
               	callq	<addr>
               	cmpq	$0x17adf, %rax          # imm = 0x17ADF
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x28, %rsp
               	retq
               	movq	<rip>, %rdi # <addr>
               	movq	<rip>, %rsi # <addr>
               	movq	<rip>, %rdx # <addr>
               	movq	<rip>, %rcx # <addr>
               	callq	<addr>
               	cmpq	$0x2d50, %rax           # imm = 0x2D50
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x28, %rsp
               	retq
               	xorl	%eax, %eax
               	movq	%rax, %xmm14
               	movsd	%xmm14, (%rsp)
               	fldl	(%rsp)
               	fstpt	0x10(%rsp)
               	leaq	0x10(%rsp), %rdi
               	movq	<rip>, %rax # <addr>
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rax, %xmm0
               	vaddsd	<rip>, %xmm0, %xmm0
               	callq	<addr>
               	leaq	0x10(%rsp), %rdi
               	callq	<addr>
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x28, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x28, %rsp
               	retq
