
scanf_reads_what_printf_wrote.x64:	file format elf64-x86-64

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
               	subq	$0x338, %rsp            # imm = 0x338
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	$-0x64, %rcx
               	movq	$-0x3039, %r8           # imm = 0xCFC7
               	movq	$-0x7fffffff, %r9       # imm = 0x80000001
               	movl	$0x0, -0x288(%rbp)
               	movl	$0x0, -0x280(%rbp)
               	movabsq	$0x4005bf0a8b145769, %rax # imm = 0x4005BF0A8B145769
               	movabsq	$0x400a000000000000, %rdx # imm = 0x400A000000000000
               	movq	%rdx, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0x330(%rbp)
               	movabsq	$-0x7e5a91e03d070ca7, %rdx # imm = 0x81A56E1FC2F8F359
               	movq	%rdx, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0x320(%rbp)
               	movabsq	$0x3ff8000000000000, %rdx # imm = 0x3FF8000000000000
               	movq	%rdx, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0x310(%rbp)
               	leaq	-0x200(%rbp), %rdi
               	movl	$0x100, %esi            # imm = 0x100
               	leaq	<rip>, %rdx
               	movabsq	$0x3fb99999a0000000, %rbx # imm = 0x3FB99999A0000000
               	fldt	-0x330(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	fldt	-0x320(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm1
               	fldt	-0x310(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm2
               	leaq	<rip>, %r12
               	leaq	-0x330(%rbp), %r13
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0x330(%rbp)
               	leaq	-0x320(%rbp), %r14
               	movsd	%xmm1, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0x320(%rbp)
               	leaq	-0x310(%rbp), %r15
               	movsd	%xmm2, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0x310(%rbp)
               	subq	$0x80, %rsp
               	movq	$-0x499602d2, (%rsp)    # imm = 0xB669FD2E
               	movabsq	$0x20000000000001, %r10 # imm = 0x20000000000001
               	movq	%r10, 0x8(%rsp)
               	movl	$0xee6b2800, %r10d      # imm = 0xEE6B2800
               	movq	%r10, 0x10(%rsp)
               	movl	$0xdeadbeef, %r10d      # imm = 0xDEADBEEF
               	movq	%r10, 0x18(%rsp)
               	movq	$0x1ed, 0x20(%rsp)      # imm = 0x1ED
               	movq	%r12, 0x60(%rsp)
               	movq	$0x71, 0x68(%rsp)
               	movq	$0x1234, 0x70(%rsp)     # imm = 0x1234
               	movq	%r13, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	movq	%r14, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x40(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x48(%rsp)
               	movq	%r15, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x50(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x58(%rsp)
               	movq	%rbx, %xmm0
               	movq	%rax, %xmm1
               	movb	$0x2, %al
               	callq	<addr>
               	addq	$0x80, %rsp
               	leaq	<rip>, %rdi
               	leaq	-0x200(%rbp), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	-0x200(%rbp), %rdi
               	leaq	<rip>, %rsi
               	leaq	-0x278(%rbp), %rdx
               	leaq	-0x270(%rbp), %rcx
               	leaq	-0x268(%rbp), %r8
               	leaq	-0x258(%rbp), %r9
               	leaq	-0x250(%rbp), %rax
               	leaq	-0x248(%rbp), %rbx
               	leaq	-0x240(%rbp), %r12
               	leaq	-0x260(%rbp), %r13
               	leaq	-0x238(%rbp), %r14
               	leaq	-0x230(%rbp), %r15
               	leaq	-0x300(%rbp), %r10
               	movq	%r10, 0xc8(%rsp)
               	leaq	-0x2f0(%rbp), %r10
               	movq	%r10, 0xc0(%rsp)
               	leaq	-0x2e0(%rbp), %r10
               	movq	%r10, 0xb8(%rsp)
               	leaq	-0x220(%rbp), %r10
               	movq	%r10, 0xb0(%rsp)
               	leaq	-0x290(%rbp), %r10
               	movq	%r10, 0xa8(%rsp)
               	leaq	-0x228(%rbp), %r10
               	movq	%r10, 0xa0(%rsp)
               	leaq	-0x288(%rbp), %r10
               	movq	%r10, 0x98(%rsp)
               	subq	$0x70, %rsp
               	movq	%rax, (%rsp)
               	movq	%rbx, 0x8(%rsp)
               	movq	%r12, 0x10(%rsp)
               	movq	%r13, 0x18(%rsp)
               	movq	%r14, 0x20(%rsp)
               	movq	%r15, 0x28(%rsp)
               	movq	0x138(%rsp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x130(%rsp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x128(%rsp), %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x120(%rsp), %r10
               	movq	%r10, 0x48(%rsp)
               	movq	0x118(%rsp), %r10
               	movq	%r10, 0x50(%rsp)
               	movq	0x110(%rsp), %r10
               	movq	%r10, 0x58(%rsp)
               	movq	0x108(%rsp), %r10
               	movq	%r10, 0x60(%rsp)
               	movb	$0x0, %al
               	callq	<addr>
               	addq	$0x70, %rsp
               	movq	%rax, %rbx
               	leaq	-0x100(%rbp), %rdi
               	movl	$0x100, %esi            # imm = 0x100
               	leaq	<rip>, %rdx
               	movsbq	-0x278(%rbp), %rcx
               	movswq	-0x270(%rbp), %r8
               	movl	-0x268(%rbp), %r9d
               	movq	-0x258(%rbp), %rax
               	movq	-0x250(%rbp), %r12
               	movl	-0x248(%rbp), %r13d
               	movq	-0x240(%rbp), %r14
               	movl	-0x260(%rbp), %r15d
               	movss	-0x238(%rbp), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movsd	-0x230(%rbp), %xmm1
               	fldt	-0x300(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm2
               	fldt	-0x2f0(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm3
               	fldt	-0x2e0(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm4
               	leaq	-0x220(%rbp), %r10
               	movq	%r10, 0xc8(%rsp)
               	movsbq	-0x290(%rbp), %r10
               	movq	%r10, 0xc0(%rsp)
               	movq	-0x228(%rbp), %r10
               	movq	%r10, 0xb8(%rsp)
               	leaq	-0x330(%rbp), %r10
               	movq	%r10, 0xb0(%rsp)
               	movsd	%xmm2, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0x330(%rbp)
               	leaq	-0x320(%rbp), %r10
               	movq	%r10, 0xa8(%rsp)
               	movsd	%xmm3, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0x320(%rbp)
               	leaq	-0x310(%rbp), %r10
               	movq	%r10, 0xa0(%rsp)
               	movsd	%xmm4, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0x310(%rbp)
               	subq	$0x80, %rsp
               	movq	%rax, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	movq	%r15, 0x20(%rsp)
               	movq	0x148(%rsp), %r10
               	movq	%r10, 0x60(%rsp)
               	movq	0x140(%rsp), %r10
               	movq	%r10, 0x68(%rsp)
               	movq	0x138(%rsp), %r10
               	movq	%r10, 0x70(%rsp)
               	movq	0x130(%rsp), %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	movq	0x128(%rsp), %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x40(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x48(%rsp)
               	movq	0x120(%rsp), %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x50(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x58(%rsp)
               	movb	$0x2, %al
               	callq	<addr>
               	addq	$0x80, %rsp
               	movl	-0x288(%rbp), %r12d
               	leaq	-0x200(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpl	%eax, %r12d
               	sete	%r12b
               	movzbq	%r12b, %r12
               	leaq	-0x200(%rbp), %rdi
               	leaq	-0x100(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	-0x100(%rbp), %rcx
               	leaq	<rip>, %rdi
               	movq	%rbx, %rsi
               	movq	%r12, %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	leaq	-0x210(%rbp), %rdx
               	leaq	-0x290(%rbp), %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movq	%rax, %rsi
               	leaq	<rip>, %rdi
               	leaq	-0x210(%rbp), %rdx
               	movsbq	-0x290(%rbp), %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	leaq	-0x280(%rbp), %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	leaq	-0x280(%rbp), %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movq	%rax, %r12
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	leaq	-0x280(%rbp), %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	<rip>, %rdi
               	movq	%rbx, %rsi
               	movq	%r12, %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	leaq	-0x268(%rbp), %rdx
               	leaq	-0x260(%rbp), %rcx
               	leaq	-0x280(%rbp), %r8
               	movb	$0x0, %al
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	leaq	-0x280(%rbp), %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movq	%rax, %rdx
               	leaq	<rip>, %rdi
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	leaq	<rip>, %rcx
               	jmp	<addr>
