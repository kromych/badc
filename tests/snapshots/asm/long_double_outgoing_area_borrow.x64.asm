
long_double_outgoing_area_borrow.x64:	file format elf64-x86-64

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

<weigh10>:
               	shlq	%rsi
               	leaq	(%rdi,%rsi), %rax
               	leaq	(%rdx,%rdx,2), %rdx
               	addq	%rdx, %rax
               	shlq	$0x2, %rcx
               	addq	%rcx, %rax
               	leaq	(%r8,%r8,4), %rcx
               	addq	%rcx, %rax
               	imulq	$0x6, %r9, %rcx
               	addq	%rcx, %rax
               	movq	0x8(%rsp), %rcx
               	imulq	$0x7, %rcx, %rcx
               	addq	%rax, %rcx
               	movq	0x10(%rsp), %rax
               	shlq	$0x3, %rax
               	addq	%rcx, %rax
               	movq	0x18(%rsp), %rcx
               	leaq	(%rcx,%rcx,8), %rcx
               	addq	%rcx, %rax
               	movq	0x20(%rsp), %rcx
               	imulq	$0xa, %rcx, %rcx
               	addq	%rcx, %rax
               	retq

<mix>:
               	subq	$0x38, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbp
               	pushq	%rbx
               	subq	$0x20, %rsp
               	leaq	(%rdi,%rdi,2), %rcx
               	leaq	(%rsi,%rsi,4), %rdx
               	leaq	(%rdi,%rsi), %r8
               	movq	%rdi, %r9
               	subq	%rsi, %r9
               	movq	%rdi, %rbx
               	imulq	%rsi, %rbx
               	leaq	0x7(%rdi), %r12
               	leaq	0x9(%rsi), %r13
               	imulq	$0xb, %rdi, %r10
               	imulq	$0xd, %rsi, %r11
               	movq	%rdi, %r14
               	xorq	%rsi, %r14
               	movq	%rdi, %r15
               	orq	$0x40, %r15
               	movq	%rsi, %rbp
               	shlq	$0x3, %rbp
               	imulq	%rdi, %rdi
               	movq	%rsi, %rax
               	imulq	%rsi, %rax
               	movq	%r10, 0x58(%rsp)
               	leaq	<rip>, %r10 # <addr>
               	movq	%r10, 0x78(%rsp)
               	fldt	(%r10)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movq	%rdx, %r10
               	shlq	%r10
               	movq	%r10, 0x70(%rsp)
               	movq	%rcx, %r10
               	addq	0x70(%rsp), %r10
               	movq	%r10, 0x70(%rsp)
               	leaq	(%r8,%r8,2), %r10
               	movq	%r10, 0x68(%rsp)
               	movq	0x70(%rsp), %r10
               	addq	0x68(%rsp), %r10
               	movq	%r10, 0x70(%rsp)
               	movq	%r9, %r10
               	shlq	$0x2, %r10
               	movq	%r10, 0x68(%rsp)
               	movq	0x70(%rsp), %r10
               	addq	0x68(%rsp), %r10
               	movq	%r10, 0x70(%rsp)
               	leaq	(%rbx,%rbx,4), %r10
               	movq	%r10, 0x68(%rsp)
               	movq	0x70(%rsp), %r10
               	addq	0x68(%rsp), %r10
               	movq	%r10, 0x70(%rsp)
               	imulq	$0x6, %r12, %r10
               	movq	%r10, 0x68(%rsp)
               	movq	0x70(%rsp), %r10
               	addq	0x68(%rsp), %r10
               	movq	%r10, 0x70(%rsp)
               	imulq	$0x7, %r13, %r10
               	movq	%r10, 0x68(%rsp)
               	movq	0x70(%rsp), %r10
               	addq	0x68(%rsp), %r10
               	movq	%r10, 0x70(%rsp)
               	movq	0x58(%rsp), %r10
               	movq	%r11, 0x58(%rsp)
               	movq	%r10, %r11
               	shlq	$0x3, %r11
               	movq	%r11, 0x68(%rsp)
               	movq	0x70(%rsp), %r11
               	addq	0x68(%rsp), %r11
               	movq	%r11, 0x70(%rsp)
               	movq	0x58(%rsp), %r11
               	movq	%r10, 0x58(%rsp)
               	leaq	(%r11,%r11,8), %r10
               	movq	%r10, 0x68(%rsp)
               	movq	0x70(%rsp), %r10
               	addq	0x68(%rsp), %r10
               	movq	%r10, 0x70(%rsp)
               	imulq	$0xa, %r14, %r10
               	movq	%r10, 0x68(%rsp)
               	movq	0x70(%rsp), %r10
               	addq	0x68(%rsp), %r10
               	movq	%r10, 0x70(%rsp)
               	imulq	$0xb, %r15, %r10
               	movq	%r10, 0x68(%rsp)
               	movq	0x70(%rsp), %r10
               	addq	0x68(%rsp), %r10
               	movq	%r10, 0x70(%rsp)
               	imulq	$0xc, %rbp, %r10
               	movq	%r10, 0x68(%rsp)
               	movq	0x70(%rsp), %r10
               	addq	0x68(%rsp), %r10
               	movq	%r10, 0x70(%rsp)
               	imulq	$0xd, %rdi, %r10
               	movq	%r10, 0x68(%rsp)
               	movq	0x70(%rsp), %r10
               	addq	0x68(%rsp), %r10
               	movq	%r10, 0x70(%rsp)
               	imulq	$0xe, %rax, %r10
               	movq	%r10, 0x68(%rsp)
               	movq	0x70(%rsp), %r10
               	addq	0x68(%rsp), %r10
               	movq	%r10, 0x70(%rsp)
               	vmulsd	<rip>, %xmm0, %xmm1
               	movq	0x78(%rsp), %r10
               	movsd	%xmm1, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x10(%r10)
               	subq	%rdi, %rax
               	addq	%rbp, %rax
               	subq	%r15, %rax
               	movq	0x58(%rsp), %r10
               	addq	%r14, %rax
               	subq	%r11, %rax
               	addq	%r10, %rax
               	movq	<rip>, %r14 # <addr>
               	movsd	%xmm0, 0x60(%rsp)
               	movq	%r13, (%rsp)
               	movq	0x70(%rsp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	%rax, 0x10(%rsp)
               	movq	%rsi, 0x18(%rsp)
               	movq	%rcx, %rdi
               	movq	%rdx, %rsi
               	movq	%r8, %rdx
               	movq	%r9, %rcx
               	movq	%r12, %r9
               	movq	%rbx, %r8
               	callq	*%r14
               	movsd	0x60(%rsp), %xmm0
               	leaq	<rip>, %rcx # <addr>
               	addq	0x70(%rsp), %rax
               	vmulsd	<rip>, %xmm0, %xmm0
               	cvttsd2si	%xmm0, %rdx
               	addq	%rdx, %rax
               	movl	$0x1, %edx
               	xorl	%esi, %esi
               	fldt	0x20(%rcx)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	comisd	<rip>, %xmm0
               	cmovbeq	%rsi, %rdx
               	addq	%rdx, %rax
               	addq	$0x20, %rsp
               	popq	%rbx
               	popq	%rbp
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	addq	$0x38, %rsp
               	retq

<main>:
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	<rip>, %rdi # <addr>
               	movq	<rip>, %rsi # <addr>
               	leaq	(%rdi,%rdi,2), %rdx
               	leaq	(%rsi,%rsi,4), %rax
               	movq	%rax, %rcx
               	shlq	%rcx
               	addq	%rdx, %rcx
               	leaq	(%rdi,%rsi), %r8
               	leaq	(%r8,%r8,2), %r9
               	addq	%rcx, %r9
               	movq	%rdi, %rcx
               	subq	%rsi, %rcx
               	movq	%rcx, %r10
               	shlq	$0x2, %r10
               	addq	%r9, %r10
               	movq	%rdi, %r9
               	imulq	%rsi, %r9
               	leaq	(%r9,%r9,4), %r11
               	addq	%r10, %r11
               	leaq	0x7(%rdi), %r10
               	imulq	$0x6, %r10, %rbx
               	addq	%r11, %rbx
               	leaq	0x9(%rsi), %r11
               	imulq	$0x7, %r11, %r12
               	addq	%rbx, %r12
               	shlq	%rax
               	addq	%rdx, %rax
               	leaq	(%r8,%r8,2), %rdx
               	addq	%rdx, %rax
               	shlq	$0x2, %rcx
               	addq	%rcx, %rax
               	leaq	(%r9,%r9,4), %rcx
               	addq	%rcx, %rax
               	imulq	$0x6, %r10, %rcx
               	addq	%rcx, %rax
               	imulq	$0x7, %r11, %rcx
               	addq	%rcx, %rax
               	imulq	$0xb, %rdi, %rcx
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %rax
               	imulq	$0xd, %rsi, %rdx
               	leaq	(%rdx,%rdx,8), %r8
               	addq	%r8, %rax
               	movq	%rdi, %r8
               	xorq	%rsi, %r8
               	imulq	$0xa, %r8, %r9
               	addq	%r9, %rax
               	movq	%rdi, %r9
               	orq	$0x40, %r9
               	imulq	$0xb, %r9, %r10
               	addq	%r10, %rax
               	movq	%rsi, %r10
               	shlq	$0x3, %r10
               	imulq	$0xc, %r10, %r11
               	addq	%r11, %rax
               	movq	%rdi, %r11
               	imulq	%rdi, %r11
               	imulq	$0xd, %r11, %rbx
               	addq	%rax, %rbx
               	movq	%rsi, %rax
               	imulq	%rsi, %rax
               	imulq	$0xe, %rax, %r13
               	addq	%r13, %rbx
               	movq	%rbx, %r13
               	shlq	$0x3, %r13
               	addq	%r13, %r12
               	subq	%r11, %rax
               	addq	%r10, %rax
               	subq	%r9, %rax
               	addq	%r8, %rax
               	subq	%rdx, %rax
               	addq	%rcx, %rax
               	leaq	(%rax,%rax,8), %rax
               	addq	%r12, %rax
               	imulq	$0xa, %rsi, %rcx
               	addq	%rcx, %rax
               	addq	%rbx, %rax
               	leaq	0x7(%rax), %rbx
               	callq	<addr>
               	cmpq	%rbx, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	retq
               	leaq	<rip>, %rax # <addr>
               	fldt	0x10(%rax)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	retq
