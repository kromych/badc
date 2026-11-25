
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
               	pushq	%rbx
               	movq	%rcx, %r10
               	leaq	(%rdi,%rdi,2), %rax
               	addq	%rsi, %rax
               	leaq	(%rdx,%rdx,4), %rcx
               	addq	%r10, %rcx
               	imulq	$0x7, %r8, %r11
               	addq	%r9, %r11
               	xorq	%rdx, %rdi
               	xorq	%r10, %rsi
               	xorq	%r9, %r8
               	leaq	(%rax,%rcx), %rdx
               	movq	%r11, %r9
               	orq	$0x1, %r9
               	movq	%rax, 0x10(%rsp)
               	movq	%rdx, %rax
               	cqto
               	idivq	%r9
               	movq	%rax, %rdx
               	movq	0x10(%rsp), %rax
               	movq	%rax, %r10
               	imulq	%rcx, %r10
               	movq	%rax, 0x10(%rsp)
               	movq	%rdx, 0x18(%rsp)
               	movq	%r10, %rax
               	cqto
               	idivq	%r9
               	movq	%rdx, %r9
               	movq	0x18(%rsp), %rdx
               	movq	0x10(%rsp), %rax
               	imulq	$0x3d1, %r10, %r10      # imm = 0x3D1
               	movq	%rsi, %rbx
               	orq	$0x1, %rbx
               	movq	%rax, 0x10(%rsp)
               	movq	%rdx, 0x18(%rsp)
               	movq	%r10, %rax
               	xorl	%edx, %edx
               	divq	%rbx
               	movq	%rax, %r10
               	movq	0x18(%rsp), %rdx
               	movq	0x10(%rsp), %rax
               	addq	%r9, %rdx
               	addq	%r10, %rdx
               	addq	%rdx, %rax
               	addq	%rcx, %rax
               	addq	%r11, %rax
               	addq	%rdi, %rax
               	addq	%rsi, %rax
               	addq	%r8, %rax
               	popq	%rbx
               	addq	$0x20, %rsp
               	retq

<shifts>:
               	leaq	(%rdi,%rdi,4), %rax
               	leaq	(%rsi,%rsi,8), %r8
               	movq	%rdi, %r9
               	xorq	%rsi, %r9
               	addq	%rdi, %rsi
               	movq	%rdx, %rdi
               	andq	$0x3f, %rdi
               	shlxq	%rdi, %rax, %rdi
               	movq	%rcx, %r10
               	andq	$0x3f, %r10
               	shrxq	%r10, %r8, %r10
               	addq	%rdx, %rcx
               	andq	$0x3f, %rcx
               	shlxq	%rcx, %r9, %rcx
               	leaq	(%rdi,%r10), %rdx
               	addq	%rdx, %rcx
               	addq	%rcx, %rax
               	addq	%r8, %rax
               	addq	%r9, %rax
               	addq	%rsi, %rax
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
               	movq	<rip>, %rax # <addr>
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rax, %xmm0
               	vaddsd	<rip>, %xmm0, %xmm0
               	leaq	0x10(%rsp), %rdi
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
