
scanf_reads_what_printf_wrote.x64:	file format elf64-x86-64

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
               	subq	$0x308, %rsp            # imm = 0x308
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbp
               	pushq	%rbx
               	subq	$0x80, %rsp
               	movl	$0x0, 0x128(%rsp)
               	movl	$0x0, 0x130(%rsp)
               	movsd	<rip>, %xmm1
               	movabsq	$0x400a000000000000, %rax # imm = 0x400A000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0xb0(%rsp)
               	movabsq	$-0x7e5a91e03d070ca7, %rax # imm = 0x81A56E1FC2F8F359
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0xc0(%rsp)
               	movabsq	$0x3ff8000000000000, %rax # imm = 0x3FF8000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0xd0(%rsp)
               	movsd	<rip>, %xmm0
               	fldt	0xb0(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm2
               	fldt	0xc0(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm3
               	fldt	0xd0(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm4
               	leaq	0xb0(%rsp), %rax
               	movsd	%xmm2, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0xb0(%rsp)
               	leaq	0xc0(%rsp), %rcx
               	movsd	%xmm3, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0xc0(%rsp)
               	leaq	0xd0(%rsp), %rdx
               	movsd	%xmm4, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0xd0(%rsp)
               	movq	$-0x499602d2, (%rsp)    # imm = 0xB669FD2E
               	movabsq	$0x20000000000001, %r10 # imm = 0x20000000000001
               	movq	%r10, 0x8(%rsp)
               	movl	$0xee6b2800, %r10d      # imm = 0xEE6B2800
               	movq	%r10, 0x10(%rsp)
               	movl	$0xdeadbeef, %r10d      # imm = 0xDEADBEEF
               	movq	%r10, 0x18(%rsp)
               	movq	$0x1ed, 0x20(%rsp)      # imm = 0x1ED
               	leaq	<rip>, %r10
               	movq	%r10, 0x60(%rsp)
               	movq	$0x71, 0x68(%rsp)
               	movq	$0x1234, 0x70(%rsp)     # imm = 0x1234
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	movq	%rcx, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x40(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x48(%rsp)
               	movq	%rdx, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x50(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x58(%rsp)
               	leaq	0x1b0(%rsp), %rdi
               	movl	$0x100, %esi            # imm = 0x100
               	leaq	<rip>, %rdx
               	movq	$-0x64, %rcx
               	movq	$-0x3039, %r8           # imm = 0xCFC7
               	movq	$-0x7fffffff, %r9       # imm = 0x80000001
               	movb	$0x2, %al
               	callq	<addr>
               	leaq	<rip>, %rdi
               	leaq	0x1b0(%rsp), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	0x160(%rsp), %r10
               	movq	%r10, (%rsp)
               	leaq	0x168(%rsp), %r10
               	movq	%r10, 0x8(%rsp)
               	leaq	0x170(%rsp), %r10
               	movq	%r10, 0x10(%rsp)
               	leaq	0x150(%rsp), %r10
               	movq	%r10, 0x18(%rsp)
               	leaq	0x178(%rsp), %r10
               	movq	%r10, 0x20(%rsp)
               	leaq	0x180(%rsp), %r10
               	movq	%r10, 0x28(%rsp)
               	leaq	0xe0(%rsp), %r10
               	movq	%r10, 0x30(%rsp)
               	leaq	0xf0(%rsp), %r10
               	movq	%r10, 0x38(%rsp)
               	leaq	0x100(%rsp), %r10
               	movq	%r10, 0x40(%rsp)
               	leaq	0x190(%rsp), %r10
               	movq	%r10, 0x48(%rsp)
               	leaq	0x120(%rsp), %r10
               	movq	%r10, 0x50(%rsp)
               	leaq	0x188(%rsp), %r10
               	movq	%r10, 0x58(%rsp)
               	leaq	0x128(%rsp), %r10
               	movq	%r10, 0x60(%rsp)
               	leaq	0x1b0(%rsp), %rdi
               	leaq	<rip>, %rsi
               	leaq	0x138(%rsp), %rdx
               	leaq	0x140(%rsp), %rcx
               	leaq	0x148(%rsp), %r8
               	leaq	0x158(%rsp), %r9
               	movb	$0x0, %al
               	callq	<addr>
               	movq	%rax, %rbx
               	movsbq	0x138(%rsp), %rcx
               	movswq	0x140(%rsp), %r8
               	movl	0x148(%rsp), %r9d
               	movq	0x158(%rsp), %rax
               	movq	0x160(%rsp), %rdx
               	movl	0x168(%rsp), %esi
               	movq	0x170(%rsp), %rdi
               	movl	0x150(%rsp), %r12d
               	movss	0x178(%rsp), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movsd	0x180(%rsp), %xmm1
               	fldt	0xe0(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm2
               	fldt	0xf0(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm3
               	fldt	0x100(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm4
               	movsbq	0x120(%rsp), %r13
               	movq	0x188(%rsp), %r14
               	leaq	0xb0(%rsp), %r15
               	movsd	%xmm2, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0xb0(%rsp)
               	leaq	0xc0(%rsp), %rbp
               	movsd	%xmm3, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0xc0(%rsp)
               	leaq	0xd0(%rsp), %r10
               	movq	%r10, 0x118(%rsp)
               	movsd	%xmm4, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0xd0(%rsp)
               	movq	%rax, (%rsp)
               	movq	%rdx, 0x8(%rsp)
               	movq	%rsi, 0x10(%rsp)
               	movq	%rdi, 0x18(%rsp)
               	movq	%r12, 0x20(%rsp)
               	leaq	0x190(%rsp), %r10
               	movq	%r10, 0x60(%rsp)
               	movq	%r13, 0x68(%rsp)
               	movq	%r14, 0x70(%rsp)
               	movq	%r15, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	movq	%rbp, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x40(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x48(%rsp)
               	movq	0x118(%rsp), %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x50(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x58(%rsp)
               	leaq	0x2b0(%rsp), %rdi
               	movl	$0x100, %esi            # imm = 0x100
               	leaq	<rip>, %rdx
               	movb	$0x2, %al
               	callq	<addr>
               	movl	0x128(%rsp), %r12d
               	leaq	0x1b0(%rsp), %rdi
               	callq	<addr>
               	cmpl	%eax, %r12d
               	sete	%r12b
               	movzbq	%r12b, %r12
               	leaq	0x1b0(%rsp), %rdi
               	leaq	0x2b0(%rsp), %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	0x2b0(%rsp), %rcx
               	movq	%rbx, %rsi
               	movq	%r12, %rdx
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	leaq	0x1a0(%rsp), %rdx
               	leaq	0x120(%rsp), %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movq	%rax, %rsi
               	movsbq	0x120(%rsp), %rcx
               	leaq	<rip>, %rdi
               	leaq	0x1a0(%rsp), %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	leaq	0x130(%rsp), %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	leaq	0x130(%rsp), %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movq	%rax, %r12
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	leaq	0x130(%rsp), %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movq	%rax, %rcx
               	movq	%rbx, %rsi
               	movq	%r12, %rdx
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	leaq	0x148(%rsp), %rdx
               	leaq	0x150(%rsp), %rcx
               	leaq	0x130(%rsp), %r8
               	movb	$0x0, %al
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	leaq	0x130(%rsp), %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movq	%rax, %rdx
               	movq	%rbx, %rsi
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	xorl	%eax, %eax
               	addq	$0x80, %rsp
               	popq	%rbx
               	popq	%rbp
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	addq	$0x308, %rsp            # imm = 0x308
               	retq
               	leaq	<rip>, %rcx
               	jmp	<addr>
