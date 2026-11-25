
compound_assign_once.x64:	file format elf64-x86-64

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

<common_type>:
               	subq	$0x38, %rsp
               	movl	<rip>, %eax # <addr>
               	andq	$-0x80, %rax
               	orq	$0x7d, %rax
               	movq	%rax, %rcx
               	shlq	$0x39, %rcx
               	sarq	$0x39, %rcx
               	movl	%ecx, %ecx
               	shrq	%rcx
               	andq	$0x7f, %rcx
               	andq	$-0x80, %rax
               	orq	%rcx, %rax
               	movl	%eax, <rip> # <addr>
               	movq	%rax, %rcx
               	shlq	$0x39, %rcx
               	sarq	$0x39, %rcx
               	cmpl	$-0x2, %ecx
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x38, %rsp
               	retq
               	andq	$-0x80, %rax
               	orq	$0x7d, %rax
               	movq	%rax, %rcx
               	shlq	$0x39, %rcx
               	sarq	$0x39, %rcx
               	movl	%ecx, %ecx
               	movl	$0xcccccccd, %edx       # imm = 0xCCCCCCCD
               	imulq	%rcx, %rdx
               	shrq	$0x22, %rdx
               	leaq	(%rdx,%rdx,4), %rdx
               	subq	%rdx, %rcx
               	andq	$-0x80, %rax
               	orq	%rcx, %rax
               	movl	%eax, <rip> # <addr>
               	movl	%eax, %ecx
               	shlq	$0x39, %rax
               	sarq	$0x39, %rax
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x38, %rsp
               	retq
               	andq	$-0x80, %rcx
               	orq	$0x3, %rcx
               	movq	%rcx, %rax
               	shlq	$0x39, %rax
               	sarq	$0x39, %rax
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rax, %xmm0
               	vmulsd	<rip>, %xmm0, %xmm0
               	cvttsd2si	%xmm0, %rax
               	andq	$0x7f, %rax
               	andq	$-0x80, %rcx
               	orq	%rax, %rcx
               	movl	%ecx, <rip> # <addr>
               	shlq	$0x39, %rcx
               	sarq	$0x39, %rcx
               	cmpl	$0x4, %ecx
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x38, %rsp
               	retq
               	xorps	%xmm0, %xmm0
               	movzbq	<rip>, %rax # <addr>
               	andq	$-0x11, %rax
               	movq	%rax, %rcx
               	sarq	$0x4, %rcx
               	andq	$0x1, %rcx
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%rcx, %xmm1
               	vaddsd	<rip>, %xmm1, %xmm1
               	ucomisd	%xmm0, %xmm1
               	setne	%cl
               	movzbq	%cl, %rcx
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rcx
               	andq	$0x1, %rcx
               	andq	$-0x11, %rax
               	shlq	$0x4, %rcx
               	orq	%rcx, %rax
               	movb	%al, <rip> # <addr>
               	sarq	$0x4, %rax
               	andq	$0x1, %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x38, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	andq	$-0xf81, %rax           # imm = 0xF07F
               	orq	$0xf00, %rax            # imm = 0xF00
               	movq	%rax, %rcx
               	sarq	$0x7, %rcx
               	andq	$0x1f, %rcx
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rcx, %xmm0
               	vsubsd	<rip>, %xmm0, %xmm0
               	cvttsd2si	%xmm0, %rcx
               	andq	$0x1f, %rcx
               	andq	$-0xf81, %rax           # imm = 0xF07F
               	shlq	$0x7, %rcx
               	orq	%rcx, %rax
               	movl	%eax, <rip> # <addr>
               	sarq	$0x7, %rax
               	andq	$0x1f, %rax
               	cmpl	$0x1d, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x38, %rsp
               	retq
               	xorl	%esi, %esi
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shlq	$0x1c, %rax
               	movq	%rax, %rcx
               	sarq	$0x1c, %rcx
               	shlq	$0x24, %rax
               	orq	$0x3, %rax
               	movq	%rcx, %rdx
               	sarq	$0x3f, %rdx
               	xorq	%rdx, %rax
               	xorq	%rdx, %rcx
               	cmpq	%rdx, %rax
               	setb	%dil
               	movzbq	%dil, %rdi
               	subq	%rdx, %rax
               	subq	%rdx, %rcx
               	subq	%rdi, %rcx
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	andq	%rdx, %r11
               	testq	%rcx, %rcx
               	setne	%r8b
               	movzbq	%r8b, %r8
               	movq	%rcx, %rdx
               	shrq	$0x20, %rdx
               	testl	%edx, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x5, %rdx
               	leaq	0x1(%rdx), %r9
               	shrxq	%rdx, %rcx, %rdi
               	movq	%rdi, %rdx
               	shrq	$0x10, %rdx
               	testq	%rdx, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x4, %rdx
               	addq	%rdx, %r9
               	shrxq	%rdx, %rdi, %rdi
               	movq	%rdi, %rdx
               	shrq	$0x8, %rdx
               	testq	%rdx, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %r9
               	shrxq	%rdx, %rdi, %rdi
               	movq	%rdi, %rdx
               	shrq	$0x4, %rdx
               	testq	%rdx, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %r9
               	shrxq	%rdx, %rdi, %rdi
               	movq	%rdi, %rdx
               	shrq	$0x2, %rdx
               	testq	%rdx, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	addq	%rdx, %r9
               	shrxq	%rdx, %rdi, %rdx
               	shrq	%rdx
               	testq	%rdx, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	addq	%r9, %rdx
               	imulq	%r8, %rdx
               	movl	$0x40, %edi
               	subq	%rdx, %rdi
               	andq	$0x3f, %rdi
               	movq	$-0x1, %r8
               	shrxq	%rdi, %r8, %rdi
               	testl	%edx, %edx
               	setne	%r8b
               	movzbq	%r8b, %r8
               	imulq	%r8, %rdi
               	andq	%rax, %rdi
               	testq	%rdi, %rdi
               	setne	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x28(%rsp)
               	movq	%rdx, %rdi
               	andq	$0x3f, %rdi
               	movl	$0x3f, %r9d
               	movq	%r9, %r10
               	subq	%rdi, %r10
               	movq	%r10, 0x20(%rsp)
               	movq	%rdx, %r8
               	shrq	$0x6, %r8
               	negq	%r8
               	movq	%r8, %r10
               	xorq	$-0x1, %r10
               	movq	%r10, 0x18(%rsp)
               	shrxq	%rdi, %rcx, %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x20(%rsp), %r10
               	shlxq	%r10, %rcx, %rcx
               	shlq	%rcx
               	shrxq	%rdi, %rax, %rax
               	orq	%rcx, %rax
               	andq	0x18(%rsp), %rax
               	movq	0x10(%rsp), %r10
               	andq	%r8, %r10
               	orq	%r10, %rax
               	orq	0x28(%rsp), %rax
               	xorps	%xmm0, %xmm0
               	movq	%rax, %r10
               	testq	%r10, %r10
               	js	<addr>
               	cvtsi2sd	%r10, %xmm0
               	jmp	<addr>
               	movq	%r10, %r8
               	shrq	%r8
               	andq	$0x1, %r10
               	orq	%r10, %r8
               	cvtsi2sd	%r8, %xmm0
               	addsd	%xmm0, %xmm0
               	leaq	0x3ff(%rdx), %rax
               	shlq	$0x34, %rax
               	orq	%r11, %rax
               	movq	%rax, %xmm1
               	mulsd	%xmm1, %xmm0
               	vmulsd	<rip>, %xmm0, %xmm0
               	movq	%xmm0, %rax
               	movq	%rax, %rdi
               	sarq	$0x3f, %rdi
               	movabsq	$0x7fffffffffffffff, %rcx # imm = 0x7FFFFFFFFFFFFFFF
               	andq	%rax, %rcx
               	shrq	$0x34, %rcx
               	leaq	-0x3ff(%rcx), %r10
               	movq	%r10, 0x18(%rsp)
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rax
               	movabsq	$0x10000000000000, %rdx # imm = 0x10000000000000
               	orq	%rax, %rdx
               	subq	$0x433, %rcx            # imm = 0x433
               	movq	%rcx, %r8
               	sarq	$0x3f, %r8
               	xorq	%r8, %rcx
               	subq	%r8, %rcx
               	movq	%rcx, %rax
               	andq	$0x7f, %rax
               	andq	$0x3f, %rcx
               	subq	%rcx, %r9
               	shrq	$0x6, %rax
               	movq	%rax, %r11
               	negq	%r11
               	movq	%r11, %r10
               	xorq	$-0x1, %r10
               	movq	%rdx, 0x28(%rsp)
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rsp), %r10
               	shlxq	%rcx, %r10, %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0x28(%rsp), %rdx
               	shrxq	%r9, %rdx, %rdx
               	shrq	%rdx
               	shlxq	%rcx, %rsi, %rax
               	orq	%rdx, %rax
               	movq	0x10(%rsp), %r10
               	movq	0x20(%rsp), %rdx
               	andq	%r10, %rdx
               	andq	%r10, %rax
               	movq	%r10, 0x10(%rsp)
               	movq	0x20(%rsp), %r10
               	andq	%r11, %r10
               	movq	%r10, 0x20(%rsp)
               	orq	0x20(%rsp), %rax
               	shrxq	%rcx, %rsi, %r10
               	movq	%r10, 0x20(%rsp)
               	shlxq	%r9, %rsi, %r9
               	shlq	%r9
               	movq	%rcx, %r10
               	movq	0x28(%rsp), %rcx
               	shrxq	%r10, %rcx, %rcx
               	orq	%r9, %rcx
               	movq	0x10(%rsp), %r10
               	andq	%r10, %rcx
               	movq	0x20(%rsp), %r9
               	andq	%r9, %r11
               	orq	%r11, %rcx
               	andq	%r10, %r9
               	movq	%r8, %r10
               	xorq	$-0x1, %r10
               	andq	%r10, %rdx
               	andq	%r8, %rcx
               	orq	%rcx, %rdx
               	andq	%r10, %rax
               	andq	%r8, %r9
               	orq	%r9, %rax
               	movq	0x18(%rsp), %r8
               	movq	%r8, %rcx
               	sarq	$0x3f, %rcx
               	xorq	$-0x1, %rcx
               	andq	%rcx, %rdx
               	andq	%rcx, %rax
               	cmpl	$0x80, %r8d
               	setge	%cl
               	movzbq	%cl, %rcx
               	negq	%rcx
               	xorq	%rdi, %rdx
               	xorq	%rdi, %rax
               	cmpq	%rdi, %rdx
               	setb	%r8b
               	movzbq	%r8b, %r8
               	subq	%rdi, %rdx
               	subq	%rdi, %rax
               	subq	%r8, %rax
               	movq	%rdi, %r8
               	xorq	$-0x1, %r8
               	movabsq	$0x7fffffffffffffff, %r9 # imm = 0x7FFFFFFFFFFFFFFF
               	xorq	%rdi, %r9
               	movq	%rcx, %rdi
               	xorq	$-0x1, %rdi
               	andq	%rdi, %rdx
               	andq	%rcx, %r8
               	orq	%r8, %rdx
               	andq	%rdi, %rax
               	andq	%rcx, %r9
               	orq	%r9, %rax
               	movabsq	$0xfffffffff, %rcx      # imm = 0xFFFFFFFFF
               	andq	%rax, %rcx
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rax
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
               	orq	%rax, %rcx
               	xorq	$0x4, %rcx
               	orq	%rdx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0xf, %eax
               	addq	$0x38, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x38, %rsp
               	retq

<main>:
               	pushq	%rax
               	movl	<rip>, %eax # <addr>
               	movq	%rax, %rcx
               	shlq	$0x39, %rcx
               	sarq	$0x39, %rcx
               	incq	%rcx
               	andq	$0x7f, %rcx
               	andq	$-0x80, %rax
               	orq	%rcx, %rax
               	movl	%eax, <rip> # <addr>
               	shlq	$0x39, %rax
               	sarq	$0x39, %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%r11
               	retq
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	popq	%r11
               	retq
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0xffffffffff001, %r11 # imm = 0xFFF0000000000FFF
               	andq	%r11, %rax
               	movabsq	$0x7fffffffff000, %rcx  # imm = 0x7FFFFFFFFF000
               	orq	%rax, %rcx
               	movq	%rcx, %rax
               	sarq	$0xc, %rax
               	shlq	$0x18, %rax
               	sarq	$0x18, %rax
               	incq	%rax
               	movabsq	$0xffffffffff, %rdx     # imm = 0xFFFFFFFFFF
               	andq	%rax, %rdx
               	movabsq	$-0xffffffffff001, %r11 # imm = 0xFFF0000000000FFF
               	andq	%r11, %rcx
               	shlq	$0xc, %rdx
               	orq	%rdx, %rcx
               	movq	%rcx, <rip> # <addr>
               	shlq	$0x18, %rax
               	sarq	$0x18, %rax
               	movabsq	$-0x8000000000, %r11    # imm = 0xFFFFFF8000000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x10, %eax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%r11
               	retq
               	movl	<rip>, %eax # <addr>
               	andq	$-0x80, %rax
               	orq	$0x7d, %rax
               	movq	%rax, %rcx
               	shlq	$0x39, %rcx
               	sarq	$0x39, %rcx
               	leaq	(%rcx,%rcx,2), %rcx
               	andq	$0x7f, %rcx
               	andq	$-0x80, %rax
               	orq	%rcx, %rax
               	movl	%eax, <rip> # <addr>
               	shlq	$0x39, %rax
               	sarq	$0x39, %rax
               	cmpl	$-0x9, %eax
               	je	<addr>
               	movl	$0x18, %eax
               	popq	%r11
               	retq
               	movzbq	<rip>, %rax # <addr>
               	andq	$-0x11, %rax
               	andq	$-0x11, %rax
               	orq	$0x10, %rax
               	movb	%al, <rip> # <addr>
               	sarq	$0x4, %rax
               	andq	$0x1, %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x1a, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movq	%rcx, %rax
               	sarq	$0xc, %rax
               	shlq	$0x18, %rax
               	sarq	$0x18, %rax
               	incq	%rax
               	movabsq	$0xffffffffff, %rdx     # imm = 0xFFFFFFFFFF
               	andq	%rax, %rdx
               	movabsq	$-0xffffffffff001, %r11 # imm = 0xFFF0000000000FFF
               	andq	%r11, %rcx
               	shlq	$0xc, %rdx
               	orq	%rdx, %rcx
               	movq	%rcx, <rip> # <addr>
               	shlq	$0x18, %rax
               	sarq	$0x18, %rax
               	movabsq	$-0x7fffffffff, %r11    # imm = 0xFFFFFF8000000001
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x11, %eax
               	jmp	<addr>
               	movl	<rip>, %eax # <addr>
               	andq	$-0x80, %rax
               	orq	$0x3f, %rax
               	movq	%rax, %rcx
               	shlq	$0x39, %rcx
               	sarq	$0x39, %rcx
               	incq	%rcx
               	movq	%rcx, %rdx
               	andq	$0x7f, %rdx
               	andq	$-0x80, %rax
               	orq	%rdx, %rax
               	movl	%eax, <rip> # <addr>
               	shlq	$0x39, %rcx
               	sarq	$0x39, %rcx
               	cmpl	$-0x40, %ecx
               	jne	<addr>
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
               	movq	%rax, %rdx
               	andq	$0x7f, %rdx
               	movl	<rip>, %ecx # <addr>
               	andq	$-0x80, %rcx
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
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	movl	<rip>, %eax # <addr>
               	andq	$-0xf81, %rax           # imm = 0xF07F
               	orq	$0x180, %rax            # imm = 0x180
               	movq	%rax, %rcx
               	sarq	$0x7, %rcx
               	andq	$0x1f, %rcx
               	leaq	(%rcx,%rcx,2), %rcx
               	andq	$0x1f, %rcx
               	andq	$-0xf81, %rax           # imm = 0xF07F
               	shlq	$0x7, %rcx
               	orq	%rcx, %rax
               	movl	%eax, <rip> # <addr>
               	sarq	$0x7, %rax
               	andq	$0x1f, %rax
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	movl	$0x1, <rip> # <addr>
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
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	movl	<rip>, %ecx # <addr>
               	movq	%rcx, %rax
               	sarq	$0x7, %rax
               	andq	$0x1f, %rax
               	shlq	%rax
               	andq	$0x1f, %rax
               	andq	$-0xf81, %rcx           # imm = 0xF07F
               	shlq	$0x7, %rax
               	orq	%rax, %rcx
               	movl	%ecx, <rip> # <addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	movl	<rip>, %eax # <addr>
               	leaq	(%rax,%rax,2), %rax
               	movl	%eax, <rip> # <addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	movq	<rip>, %rcx # <addr>
               	movq	%rcx, %rax
               	sarq	$0xc, %rax
               	shlq	$0x18, %rax
               	sarq	$0x18, %rax
               	decq	%rax
               	movabsq	$0xffffffffff, %r11     # imm = 0xFFFFFFFFFF
               	andq	%r11, %rax
               	movabsq	$-0xffffffffff001, %r11 # imm = 0xFFF0000000000FFF
               	andq	%r11, %rcx
               	shlq	$0xc, %rax
               	orq	%rax, %rcx
               	movq	%rcx, <rip> # <addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	movsd	<rip>, %xmm0 # <addr>
               	vaddsd	<rip>, %xmm0, %xmm0
               	movsd	%xmm0, <rip> # <addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	movzbq	<rip>, %rax # <addr>
               	andq	$-0x11, %rax
               	orq	$0x10, %rax
               	movb	%al, <rip> # <addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x6, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
