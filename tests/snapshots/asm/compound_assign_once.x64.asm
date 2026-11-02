
compound_assign_once.x64:	file format elf64-x86-64

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

<common_type>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x28, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movl	<rip>, %eax # <addr>
               	andq	$-0x80, %rax
               	orq	$0x7d, %rax
               	movl	%eax, <rip> # <addr>
               	movl	<rip>, %eax # <addr>
               	shlq	$0x39, %rax
               	sarq	$0x39, %rax
               	movl	%eax, %eax
               	shrq	%rax
               	andq	$0x7f, %rax
               	movl	<rip>, %ecx # <addr>
               	andq	$-0x80, %rcx
               	orq	%rcx, %rax
               	movl	%eax, <rip> # <addr>
               	movl	<rip>, %eax # <addr>
               	shlq	$0x39, %rax
               	sarq	$0x39, %rax
               	cmpl	$-0x2, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	<rip>, %eax # <addr>
               	andq	$-0x80, %rax
               	orq	$0x7d, %rax
               	movl	%eax, <rip> # <addr>
               	movl	<rip>, %eax # <addr>
               	shlq	$0x39, %rax
               	sarq	$0x39, %rax
               	movl	%eax, %eax
               	movl	$0xcccccccd, %ecx       # imm = 0xCCCCCCCD
               	imulq	%rax, %rcx
               	shrq	$0x22, %rcx
               	leaq	(%rcx,%rcx,4), %rcx
               	subq	%rcx, %rax
               	movl	<rip>, %ecx # <addr>
               	andq	$-0x80, %rcx
               	orq	%rcx, %rax
               	movl	%eax, <rip> # <addr>
               	movl	<rip>, %eax # <addr>
               	shlq	$0x39, %rax
               	sarq	$0x39, %rax
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	<rip>, %eax # <addr>
               	andq	$-0x80, %rax
               	orq	$0x3, %rax
               	movl	%eax, <rip> # <addr>
               	movl	<rip>, %eax # <addr>
               	shlq	$0x39, %rax
               	sarq	$0x39, %rax
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rax, %xmm0
               	movabsq	$0x3ff8000000000000, %rax # imm = 0x3FF8000000000000
               	movq	%rax, %xmm15
               	mulsd	%xmm15, %xmm0
               	cvttsd2si	%xmm0, %rax
               	andq	$0x7f, %rax
               	movl	<rip>, %ecx # <addr>
               	andq	$-0x80, %rcx
               	orq	%rcx, %rax
               	movl	%eax, <rip> # <addr>
               	movl	<rip>, %eax # <addr>
               	shlq	$0x39, %rax
               	sarq	$0x39, %rax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	xorl	%ecx, %ecx
               	movzbq	<rip>, %rax # <addr>
               	andq	$-0x11, %rax
               	movb	%al, <rip> # <addr>
               	movzbq	<rip>, %rax # <addr>
               	sarq	$0x4, %rax
               	andq	$0x1, %rax
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rax, %xmm0
               	movabsq	$0x3fd0000000000000, %rax # imm = 0x3FD0000000000000
               	movq	%rax, %xmm15
               	addsd	%xmm15, %xmm0
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%dl
               	movzbq	%dl, %rdx
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rdx
               	andq	$0x1, %rdx
               	movzbq	<rip>, %rsi # <addr>
               	andq	$-0x11, %rsi
               	shlq	$0x4, %rdx
               	orq	%rsi, %rdx
               	movb	%dl, <rip> # <addr>
               	movzbq	<rip>, %rdx # <addr>
               	sarq	$0x4, %rdx
               	andq	$0x1, %rdx
               	cmpl	$0x1, %edx
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	<rip>, %edx # <addr>
               	andq	$-0xf81, %rdx           # imm = 0xF07F
               	orq	$0xf00, %rdx            # imm = 0xF00
               	movl	%edx, <rip> # <addr>
               	movl	<rip>, %edx # <addr>
               	sarq	$0x7, %rdx
               	andq	$0x1f, %rdx
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rdx, %xmm0
               	movabsq	$0x3fe0000000000000, %rdx # imm = 0x3FE0000000000000
               	movq	%rdx, %xmm15
               	subsd	%xmm15, %xmm0
               	cvttsd2si	%xmm0, %rsi
               	andq	$0x1f, %rsi
               	movl	<rip>, %edi # <addr>
               	andq	$-0xf81, %rdi           # imm = 0xF07F
               	shlq	$0x7, %rsi
               	orq	%rdi, %rsi
               	movl	%esi, <rip> # <addr>
               	movl	<rip>, %esi # <addr>
               	sarq	$0x7, %rsi
               	andq	$0x1f, %rsi
               	cmpl	$0x1d, %esi
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x4b800000, %esi       # imm = 0x4B800000
               	xorl	%edi, %edi
               	movq	%rsi, %xmm14
               	movq	%rdi, %xmm15
               	vaddss	%xmm15, %xmm14, %xmm0
               	cvttss2si	%xmm0, %rsi
               	cmpl	$0x1000000, %esi        # imm = 0x1000000
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movabsq	$0x43e8000000000000, %rsi # imm = 0x43E8000000000000
               	movabsq	$0x4000000000000000, %rdi # imm = 0x4000000000000000
               	movq	%rsi, %xmm14
               	movq	%rdi, %xmm15
               	vdivsd	%xmm15, %xmm14, %xmm0
               	movapd	%xmm0, %xmm14
               	movabsq	$0x43e0000000000000, %r11 # imm = 0x43E0000000000000
               	movq	%r11, %xmm15
               	ucomisd	%xmm15, %xmm14
               	jae	<addr>
               	cvttsd2si	%xmm14, %rsi
               	jmp	<addr>
               	subsd	%xmm15, %xmm14
               	cvttsd2si	%xmm14, %rsi
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	orq	%r11, %rsi
               	movabsq	$0x6000000000000000, %r11 # imm = 0x6000000000000000
               	cmpq	%r11, %rsi
               	je	<addr>
               	movl	$0xb, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movq	%rcx, %xmm14
               	movq	%rax, %xmm15
               	vaddsd	%xmm15, %xmm14, %xmm0
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	andq	$0xff, %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0xc, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x3f, %r12d
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movq	%rax, -0x8(%rbp)
               	movsd	-0x8(%rbp), %xmm0
               	movq	%rax, %xmm14
               	vmulsd	%xmm0, %xmm14, %xmm0
               	movq	%rdx, %xmm15
               	subsd	%xmm15, %xmm0
               	movsd	%xmm0, -0x8(%rbp)
               	movq	-0x8(%rbp), %rdx
               	movq	%rdx, %rax
               	sarq	$0x3f, %rax
               	movabsq	$0x7fffffffffffffff, %rsi # imm = 0x7FFFFFFFFFFFFFFF
               	andq	%rdx, %rsi
               	shrq	$0x34, %rsi
               	leaq	-0x3ff(%rsi), %rbx
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rdx
               	movabsq	$0x10000000000000, %r8  # imm = 0x10000000000000
               	orq	%rdx, %r8
               	subq	$0x433, %rsi            # imm = 0x433
               	movq	%rsi, %rdx
               	sarq	$0x3f, %rdx
               	xorq	%rdx, %rsi
               	subq	%rdx, %rsi
               	movq	%rsi, %rdi
               	andq	$0x7f, %rdi
               	andq	$0x3f, %rsi
               	subq	%rsi, %r12
               	shrq	$0x6, %rdi
               	movq	%rdi, %r9
               	negq	%r9
               	movq	%r9, %rdi
               	xorq	$-0x1, %rdi
               	shlxq	%rsi, %r8, %r13
               	shrxq	%r12, %r8, %r14
               	shrq	%r14
               	shlxq	%rsi, %rcx, %r15
               	orq	%r15, %r14
               	movq	%r13, %r15
               	andq	%rdi, %r15
               	andq	%rdi, %r14
               	andq	%r9, %r13
               	orq	%r13, %r14
               	shrxq	%rsi, %rcx, %r13
               	shlxq	%r12, %rcx, %rcx
               	shlq	%rcx
               	shrxq	%rsi, %r8, %rsi
               	orq	%rsi, %rcx
               	andq	%rdi, %rcx
               	andq	%r13, %r9
               	orq	%rcx, %r9
               	andq	%r13, %rdi
               	movq	%rdx, %rcx
               	xorq	$-0x1, %rcx
               	andq	%rcx, %r15
               	andq	%rdx, %r9
               	orq	%r15, %r9
               	andq	%r14, %rcx
               	andq	%rdi, %rdx
               	orq	%rcx, %rdx
               	movq	%rbx, %rcx
               	sarq	$0x3f, %rcx
               	xorq	$-0x1, %rcx
               	andq	%rcx, %r9
               	movq	%rdx, %rsi
               	andq	%rcx, %rsi
               	cmpl	$0x80, %ebx
               	setge	%cl
               	movzbq	%cl, %rcx
               	negq	%rcx
               	movq	%r9, %rdx
               	xorq	%rax, %rdx
               	xorq	%rax, %rsi
               	cmpq	%rax, %rdx
               	setb	%dil
               	movzbq	%dil, %rdi
               	subq	%rax, %rdx
               	subq	%rax, %rsi
               	subq	%rdi, %rsi
               	movq	%rax, %rdi
               	xorq	$-0x1, %rdi
               	movabsq	$0x7fffffffffffffff, %r8 # imm = 0x7FFFFFFFFFFFFFFF
               	xorq	%rax, %r8
               	movq	%rcx, %rax
               	xorq	$-0x1, %rax
               	andq	%rax, %rdx
               	andq	%rcx, %rdi
               	orq	%rdi, %rdx
               	andq	%rsi, %rax
               	andq	%r8, %rcx
               	orq	%rcx, %rax
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x3f, %r12d
               	xorl	%edi, %edi
               	movabsq	$0x401c000000000000, %rax # imm = 0x401C000000000000
               	movabsq	$-0x4010000000000000, %rcx # imm = 0xBFF0000000000000
               	movq	%rcx, -0x8(%rbp)
               	movsd	-0x8(%rbp), %xmm0
               	movq	%rax, %xmm14
               	vmulsd	%xmm0, %xmm14, %xmm0
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movq	%rax, %xmm15
               	divsd	%xmm15, %xmm0
               	movsd	%xmm0, -0x8(%rbp)
               	movq	-0x8(%rbp), %rcx
               	movq	%rcx, %rax
               	sarq	$0x3f, %rax
               	movabsq	$0x7fffffffffffffff, %rdx # imm = 0x7FFFFFFFFFFFFFFF
               	andq	%rcx, %rdx
               	shrq	$0x34, %rdx
               	leaq	-0x3ff(%rdx), %rbx
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rcx
               	movabsq	$0x10000000000000, %r8  # imm = 0x10000000000000
               	orq	%rcx, %r8
               	subq	$0x433, %rdx            # imm = 0x433
               	movq	%rdx, %rcx
               	sarq	$0x3f, %rcx
               	xorq	%rcx, %rdx
               	subq	%rcx, %rdx
               	movq	%rdx, %rsi
               	andq	$0x7f, %rsi
               	andq	$0x3f, %rdx
               	subq	%rdx, %r12
               	shrq	$0x6, %rsi
               	movq	%rsi, %r9
               	negq	%r9
               	movq	%r9, %rsi
               	xorq	$-0x1, %rsi
               	shlxq	%rdx, %r8, %r13
               	shrxq	%r12, %r8, %r14
               	shrq	%r14
               	shlxq	%rdx, %rdi, %r15
               	orq	%r15, %r14
               	movq	%r13, %r15
               	andq	%rsi, %r15
               	andq	%rsi, %r14
               	andq	%r9, %r13
               	orq	%r13, %r14
               	shrxq	%rdx, %rdi, %r13
               	shlxq	%r12, %rdi, %rdi
               	shlq	%rdi
               	shrxq	%rdx, %r8, %rdx
               	orq	%rdi, %rdx
               	andq	%rsi, %rdx
               	andq	%r13, %r9
               	orq	%rdx, %r9
               	andq	%r13, %rsi
               	movq	%rcx, %rdx
               	xorq	$-0x1, %rdx
               	andq	%rdx, %r15
               	andq	%rcx, %r9
               	orq	%r15, %r9
               	andq	%r14, %rdx
               	andq	%rsi, %rcx
               	orq	%rcx, %rdx
               	movq	%rbx, %rcx
               	sarq	$0x3f, %rcx
               	xorq	$-0x1, %rcx
               	andq	%rcx, %r9
               	movq	%rdx, %rsi
               	andq	%rcx, %rsi
               	cmpl	$0x80, %ebx
               	setge	%cl
               	movzbq	%cl, %rcx
               	negq	%rcx
               	movq	%r9, %rdx
               	xorq	%rax, %rdx
               	xorq	%rax, %rsi
               	cmpq	%rax, %rdx
               	setb	%dil
               	movzbq	%dil, %rdi
               	subq	%rax, %rdx
               	subq	%rax, %rsi
               	subq	%rdi, %rsi
               	movq	%rax, %rdi
               	xorq	$-0x1, %rdi
               	movabsq	$0x7fffffffffffffff, %r8 # imm = 0x7FFFFFFFFFFFFFFF
               	xorq	%rax, %r8
               	movq	%rcx, %rax
               	xorq	$-0x1, %rax
               	andq	%rax, %rdx
               	andq	%rcx, %rdi
               	orq	%rdi, %rdx
               	andq	%rsi, %rax
               	andq	%r8, %rcx
               	orq	%rcx, %rax
               	xorq	$-0x3, %rdx
               	xorq	$-0x1, %rax
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	xorl	%esi, %esi
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rax
               	movq	$0x3, <rip> # <addr>
               	movq	%rax, <rip> # <addr>
               	shlq	$0x1c, %rax
               	movq	%rax, %rcx
               	sarq	$0x1c, %rcx
               	shlq	$0x24, %rax
               	movq	%rax, %rdx
               	orq	$0x3, %rdx
               	movq	%rcx, %rax
               	sarq	$0x3f, %rax
               	xorq	%rax, %rdx
               	xorq	%rax, %rcx
               	cmpq	%rax, %rdx
               	setb	%r8b
               	movzbq	%r8b, %r8
               	movq	%rdx, %rdi
               	subq	%rax, %rdi
               	subq	%rax, %rcx
               	subq	%r8, %rcx
               	movabsq	$-0x8000000000000000, %rbx # imm = 0x8000000000000000
               	andq	%rax, %rbx
               	testq	%rcx, %rcx
               	setne	%r8b
               	movzbq	%r8b, %r8
               	movq	%rcx, %rax
               	shrq	$0x20, %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	shlq	$0x5, %rax
               	leaq	0x1(%rax), %r9
               	shrxq	%rax, %rcx, %rax
               	movq	%rax, %rdx
               	shrq	$0x10, %rdx
               	testq	%rdx, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x4, %rdx
               	addq	%rdx, %r9
               	shrxq	%rdx, %rax, %rax
               	movq	%rax, %rdx
               	shrq	$0x8, %rdx
               	testq	%rdx, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %r9
               	shrxq	%rdx, %rax, %rax
               	movq	%rax, %rdx
               	shrq	$0x4, %rdx
               	testq	%rdx, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %r9
               	shrxq	%rdx, %rax, %rax
               	movq	%rax, %rdx
               	shrq	$0x2, %rdx
               	testq	%rdx, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	addq	%rdx, %r9
               	shrxq	%rdx, %rax, %rax
               	shrq	%rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	addq	%r9, %rax
               	imulq	%r8, %rax
               	movl	$0x40, %edx
               	subq	%rax, %rdx
               	andq	$0x3f, %rdx
               	movq	$-0x1, %r8
               	shrxq	%rdx, %r8, %rdx
               	testq	%rax, %rax
               	setne	%r8b
               	movzbq	%r8b, %r8
               	imulq	%r8, %rdx
               	andq	%rdi, %rdx
               	testq	%rdx, %rdx
               	setne	%r12b
               	movzbq	%r12b, %r12
               	movq	%rax, %r8
               	andq	$0x7f, %r8
               	movq	%rax, %rdx
               	andq	$0x3f, %rdx
               	movl	$0x3f, %r9d
               	movq	%r9, %r13
               	subq	%rdx, %r13
               	shrq	$0x6, %r8
               	negq	%r8
               	movq	%r8, %r14
               	xorq	$-0x1, %r14
               	shrxq	%rdx, %rcx, %r15
               	shlxq	%r13, %rcx, %rcx
               	shlq	%rcx
               	shrxq	%rdx, %rdi, %rdx
               	orq	%rdx, %rcx
               	andq	%r14, %rcx
               	andq	%r15, %r8
               	orq	%r8, %rcx
               	orq	%r12, %rcx
               	xorps	%xmm0, %xmm0
               	movq	%rcx, %r10
               	testq	%r10, %r10
               	js	<addr>
               	cvtsi2sd	%r10, %xmm0
               	jmp	<addr>
               	movq	%r10, %r11
               	shrq	%r11
               	andq	$0x1, %r10
               	orq	%r10, %r11
               	cvtsi2sd	%r11, %xmm0
               	addsd	%xmm0, %xmm0
               	addq	$0x3ff, %rax            # imm = 0x3FF
               	shlq	$0x34, %rax
               	orq	%rbx, %rax
               	movq	%rax, -0x8(%rbp)
               	movsd	-0x8(%rbp), %xmm1
               	mulsd	%xmm1, %xmm0
               	movabsq	$0x3ff8000000000000, %rax # imm = 0x3FF8000000000000
               	movq	%rax, %xmm15
               	mulsd	%xmm15, %xmm0
               	movsd	%xmm0, -0x8(%rbp)
               	movq	-0x8(%rbp), %rcx
               	movq	%rcx, %rax
               	sarq	$0x3f, %rax
               	movabsq	$0x7fffffffffffffff, %rdx # imm = 0x7FFFFFFFFFFFFFFF
               	andq	%rcx, %rdx
               	shrq	$0x34, %rdx
               	leaq	-0x3ff(%rdx), %rbx
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rcx
               	movabsq	$0x10000000000000, %r8  # imm = 0x10000000000000
               	orq	%rcx, %r8
               	subq	$0x433, %rdx            # imm = 0x433
               	movq	%rdx, %rcx
               	sarq	$0x3f, %rcx
               	xorq	%rcx, %rdx
               	subq	%rcx, %rdx
               	movq	%rdx, %rdi
               	andq	$0x7f, %rdi
               	andq	$0x3f, %rdx
               	movq	%r9, %r12
               	subq	%rdx, %r12
               	shrq	$0x6, %rdi
               	movq	%rdi, %r9
               	negq	%r9
               	movq	%r9, %rdi
               	xorq	$-0x1, %rdi
               	shlxq	%rdx, %r8, %r13
               	shrxq	%r12, %r8, %r14
               	shrq	%r14
               	shlxq	%rdx, %rsi, %r15
               	orq	%r15, %r14
               	movq	%r13, %r15
               	andq	%rdi, %r15
               	andq	%rdi, %r14
               	andq	%r9, %r13
               	orq	%r13, %r14
               	shrxq	%rdx, %rsi, %r13
               	shlxq	%r12, %rsi, %r12
               	shlq	%r12
               	shrxq	%rdx, %r8, %rdx
               	orq	%r12, %rdx
               	andq	%rdi, %rdx
               	andq	%r13, %r9
               	orq	%rdx, %r9
               	andq	%r13, %rdi
               	movq	%rcx, %rdx
               	xorq	$-0x1, %rdx
               	andq	%rdx, %r15
               	andq	%rcx, %r9
               	orq	%r15, %r9
               	andq	%r14, %rdx
               	andq	%rdi, %rcx
               	orq	%rcx, %rdx
               	movq	%rbx, %rcx
               	sarq	$0x3f, %rcx
               	xorq	$-0x1, %rcx
               	andq	%rcx, %r9
               	movq	%rdx, %rdi
               	andq	%rcx, %rdi
               	cmpl	$0x80, %ebx
               	setge	%cl
               	movzbq	%cl, %rcx
               	negq	%rcx
               	movq	%r9, %rdx
               	xorq	%rax, %rdx
               	xorq	%rax, %rdi
               	cmpq	%rax, %rdx
               	setb	%r8b
               	movzbq	%r8b, %r8
               	subq	%rax, %rdx
               	subq	%rax, %rdi
               	subq	%r8, %rdi
               	movq	%rax, %r8
               	xorq	$-0x1, %r8
               	movabsq	$0x7fffffffffffffff, %r9 # imm = 0x7FFFFFFFFFFFFFFF
               	xorq	%rax, %r9
               	movq	%rcx, %rax
               	xorq	$-0x1, %rax
               	andq	%rax, %rdx
               	andq	%rcx, %r8
               	orq	%r8, %rdx
               	andq	%rdi, %rax
               	andq	%r9, %rcx
               	orq	%rcx, %rax
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rax
               	movq	<rip>, %rcx # <addr>
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rcx
               	orq	%rdx, %rsi
               	orq	%rcx, %rax
               	movq	%rsi, <rip> # <addr>
               	movq	%rax, <rip> # <addr>
               	movq	%rsi, %rcx
               	shlq	$0x1c, %rcx
               	shlq	$0x1c, %rax
               	shrq	$0x24, %rsi
               	orq	%rsi, %rax
               	movq	%rax, %rdx
               	sarq	$0x1c, %rdx
               	shrq	$0x1c, %rcx
               	shlq	$0x24, %rax
               	orq	%rcx, %rax
               	xorq	$0x4, %rax
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	<rip>, %eax # <addr>
               	movq	%rax, %rcx
               	shlq	$0x39, %rcx
               	sarq	$0x39, %rcx
               	incq	%rcx
               	andq	$0x7f, %rcx
               	andq	$-0x80, %rax
               	orq	%rcx, %rax
               	movl	%eax, <rip> # <addr>
               	movl	<rip>, %eax # <addr>
               	shlq	$0x39, %rax
               	sarq	$0x39, %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbp
               	retq
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	popq	%rbp
               	retq
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0xffffffffff001, %r11 # imm = 0xFFF0000000000FFF
               	andq	%r11, %rax
               	movabsq	$0x7fffffffff000, %r11  # imm = 0x7FFFFFFFFF000
               	orq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rcx
               	sarq	$0xc, %rcx
               	shlq	$0x18, %rcx
               	sarq	$0x18, %rcx
               	incq	%rcx
               	movabsq	$0xffffffffff, %rdx     # imm = 0xFFFFFFFFFF
               	andq	%rcx, %rdx
               	movabsq	$-0xffffffffff001, %r11 # imm = 0xFFF0000000000FFF
               	andq	%r11, %rax
               	shlq	$0xc, %rdx
               	orq	%rdx, %rax
               	movq	%rax, <rip> # <addr>
               	shlq	$0x18, %rcx
               	sarq	$0x18, %rcx
               	movabsq	$-0x8000000000, %r11    # imm = 0xFFFFFF8000000000
               	movq	%rcx, %rax
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x10, %eax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbp
               	retq
               	movl	<rip>, %eax # <addr>
               	andq	$-0x80, %rax
               	orq	$0x7d, %rax
               	movl	%eax, <rip> # <addr>
               	movl	<rip>, %eax # <addr>
               	shlq	$0x39, %rax
               	sarq	$0x39, %rax
               	leaq	(%rax,%rax,2), %rax
               	andq	$0x7f, %rax
               	movl	<rip>, %ecx # <addr>
               	andq	$-0x80, %rcx
               	orq	%rcx, %rax
               	movl	%eax, <rip> # <addr>
               	movl	<rip>, %eax # <addr>
               	shlq	$0x39, %rax
               	sarq	$0x39, %rax
               	cmpl	$-0x9, %eax
               	je	<addr>
               	movl	$0x18, %eax
               	popq	%rbp
               	retq
               	movzbq	<rip>, %rax # <addr>
               	andq	$-0x11, %rax
               	movb	%al, <rip> # <addr>
               	movzbq	<rip>, %rax # <addr>
               	andq	$-0x11, %rax
               	orq	$0x10, %rax
               	movb	%al, <rip> # <addr>
               	movzbq	<rip>, %rax # <addr>
               	sarq	$0x4, %rax
               	andq	$0x1, %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x1a, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rcx
               	sarq	$0xc, %rcx
               	shlq	$0x18, %rcx
               	sarq	$0x18, %rcx
               	incq	%rcx
               	movabsq	$0xffffffffff, %rdx     # imm = 0xFFFFFFFFFF
               	andq	%rcx, %rdx
               	movabsq	$-0xffffffffff001, %r11 # imm = 0xFFF0000000000FFF
               	andq	%r11, %rax
               	shlq	$0xc, %rdx
               	orq	%rdx, %rax
               	movq	%rax, <rip> # <addr>
               	shlq	$0x18, %rcx
               	sarq	$0x18, %rcx
               	movabsq	$-0x7fffffffff, %r11    # imm = 0xFFFFFF8000000001
               	movq	%rcx, %rax
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x11, %eax
               	jmp	<addr>
               	movl	<rip>, %eax # <addr>
               	andq	$-0x80, %rax
               	orq	$0x3f, %rax
               	movl	%eax, <rip> # <addr>
               	movl	<rip>, %eax # <addr>
               	shlq	$0x39, %rax
               	sarq	$0x39, %rax
               	incq	%rax
               	movq	%rax, %rcx
               	andq	$0x7f, %rcx
               	movl	<rip>, %edx # <addr>
               	andq	$-0x80, %rdx
               	orq	%rdx, %rcx
               	movl	%ecx, <rip> # <addr>
               	shlq	$0x39, %rax
               	sarq	$0x39, %rax
               	cmpl	$-0x40, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	shlq	$0x39, %rax
               	sarq	$0x39, %rax
               	cmpl	$-0x40, %eax
               	je	<addr>
               	movl	$0x12, %eax
               	jmp	<addr>
               	movl	<rip>, %eax # <addr>
               	andq	$-0x80, %rax
               	orq	$0x3c, %rax
               	movl	%eax, <rip> # <addr>
               	movl	<rip>, %eax # <addr>
               	shlq	$0x39, %rax
               	sarq	$0x39, %rax
               	addq	$0xa, %rax
               	movq	%rax, %rcx
               	andq	$0x7f, %rcx
               	movl	<rip>, %edx # <addr>
               	andq	$-0x80, %rdx
               	orq	%rdx, %rcx
               	movl	%ecx, <rip> # <addr>
               	shlq	$0x39, %rax
               	sarq	$0x39, %rax
               	cmpl	$-0x3a, %eax
               	je	<addr>
               	movl	$0x13, %eax
               	jmp	<addr>
               	movl	<rip>, %eax # <addr>
               	andq	$-0xf81, %rax           # imm = 0xF07F
               	orq	$0xf80, %rax            # imm = 0xF80
               	movl	%eax, <rip> # <addr>
               	movl	<rip>, %eax # <addr>
               	sarq	$0x7, %rax
               	andq	$0x1f, %rax
               	incq	%rax
               	andq	$0x1f, %rax
               	movl	<rip>, %ecx # <addr>
               	andq	$-0xf81, %rcx           # imm = 0xF07F
               	movq	%rax, %rdx
               	shlq	$0x7, %rdx
               	orq	%rdx, %rcx
               	movl	%ecx, <rip> # <addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	sarq	$0x7, %rax
               	testb	$0x1f, %al
               	je	<addr>
               	movl	$0x14, %eax
               	jmp	<addr>
               	movzbq	<rip>, %rax # <addr>
               	andq	$-0x11, %rax
               	orq	$0x10, %rax
               	movb	%al, <rip> # <addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	<rip>, %eax # <addr>
               	addq	$0x5, %rax
               	movl	%eax, <rip> # <addr>
               	leaq	<rip>, %rax # <addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	$0x5, %ecx
               	je	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	movl	<rip>, %ecx # <addr>
               	andq	$-0xf81, %rcx           # imm = 0xF07F
               	orq	$0x180, %rcx            # imm = 0x180
               	movl	%ecx, <rip> # <addr>
               	addq	$0x18, %rax
               	movl	<rip>, %ecx # <addr>
               	sarq	$0x7, %rcx
               	andq	$0x1f, %rcx
               	leaq	(%rcx,%rcx,2), %rcx
               	andq	$0x1f, %rcx
               	movl	<rip>, %edx # <addr>
               	andq	$-0xf81, %rdx           # imm = 0xF07F
               	shlq	$0x7, %rcx
               	orq	%rdx, %rcx
               	movl	%ecx, <rip> # <addr>
               	movl	<rip>, %ecx # <addr>
               	sarq	$0x7, %rcx
               	andq	$0x1f, %rcx
               	cmpl	$0x9, %ecx
               	je	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	movl	$0x0, <rip> # <addr>
               	movl	$0x1, <rip> # <addr>
               	movl	0x8(%rax), %ecx
               	movq	%rcx, %rdx
               	shlq	$0x39, %rdx
               	sarq	$0x39, %rdx
               	incq	%rdx
               	andq	$0x7f, %rdx
               	andq	$-0x80, %rcx
               	orq	%rdx, %rcx
               	movl	%ecx, 0x8(%rax)
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	leaq	<rip>, %rax # <addr>
               	addq	$0x18, %rax
               	movl	0x8(%rax), %ecx
               	movq	%rcx, %rdx
               	sarq	$0x7, %rdx
               	andq	$0x1f, %rdx
               	shlq	%rdx
               	andq	$0x1f, %rdx
               	andq	$-0xf81, %rcx           # imm = 0xF07F
               	shlq	$0x7, %rdx
               	orq	%rdx, %rcx
               	movl	%ecx, 0x8(%rax)
               	movl	<rip>, %ecx # <addr>
               	incq	%rcx
               	movl	%ecx, <rip> # <addr>
               	movl	0x4(%rax), %ecx
               	leaq	(%rcx,%rcx,2), %rcx
               	movl	%ecx, 0x4(%rax)
               	movl	<rip>, %ecx # <addr>
               	incq	%rcx
               	movl	%ecx, <rip> # <addr>
               	movq	0x8(%rax), %rcx
               	movq	%rcx, %rdx
               	sarq	$0xc, %rdx
               	shlq	$0x18, %rdx
               	sarq	$0x18, %rdx
               	decq	%rdx
               	movabsq	$0xffffffffff, %r11     # imm = 0xFFFFFFFFFF
               	andq	%r11, %rdx
               	movabsq	$-0xffffffffff001, %r11 # imm = 0xFFF0000000000FFF
               	andq	%r11, %rcx
               	shlq	$0xc, %rdx
               	orq	%rdx, %rcx
               	movq	%rcx, 0x8(%rax)
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	leaq	<rip>, %rax # <addr>
               	addq	$0x18, %rax
               	movsd	0x10(%rax), %xmm0
               	movabsq	$0x3ff0000000000000, %rcx # imm = 0x3FF0000000000000
               	movq	%rcx, %xmm15
               	addsd	%xmm15, %xmm0
               	movsd	%xmm0, 0x10(%rax)
               	movl	<rip>, %ecx # <addr>
               	incq	%rcx
               	movl	%ecx, <rip> # <addr>
               	movzbq	0xe(%rax), %rcx
               	andq	$-0x11, %rcx
               	orq	$0x10, %rcx
               	movb	%cl, 0xe(%rax)
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x6, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
