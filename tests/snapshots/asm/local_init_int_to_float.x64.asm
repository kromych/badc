
local_init_int_to_float.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x90, %rsp
               	leaq	-0x8(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movzbq	(%rcx), %rdx
               	movb	%dl, (%rax)
               	movzbq	0x1(%rcx), %rdx
               	movb	%dl, 0x1(%rax)
               	movzbq	0x2(%rcx), %rdx
               	movb	%dl, 0x2(%rax)
               	movzbq	0x3(%rcx), %rdx
               	movb	%dl, 0x3(%rax)
               	popq	%rdx
               	leaq	-0x8(%rbp), %rax
               	movzbq	(%rax), %rax
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rax, %xmm0
               	movl	$0x4227999a, %eax       # imm = 0x4227999A
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	setb	%al
               	movzbq	%al, %rax
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x42286666, %eax       # imm = 0x42286666
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	seta	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rdi
               	cvtss2sd	%xmm0, %xmm0
               	movb	$0x1, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movl	$0x3039, %eax           # imm = 0x3039
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rax, %xmm0
               	movl	$0x4640e200, %eax       # imm = 0x4640E200
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	setb	%al
               	movzbq	%al, %rax
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x4640e600, %eax       # imm = 0x4640E600
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	seta	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rdi
               	cvtss2sd	%xmm0, %xmm0
               	movb	$0x1, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x2, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movabsq	$-0x7, %rax
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rax, %xmm0
               	movabsq	$0x401e000000000000, %rax # imm = 0x401E000000000000
               	movq	%rax, %xmm1
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm1
               	ucomisd	%xmm1, %xmm0
               	setb	%al
               	movzbq	%al, %rax
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movabsq	$0x401a000000000000, %rax # imm = 0x401A000000000000
               	movq	%rax, %xmm1
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm1
               	ucomisd	%xmm1, %xmm0
               	seta	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rdi
               	movb	$0x1, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x3, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rax, %xmm0
               	movl	$0x4f7fb434, %eax       # imm = 0x4F7FB434
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	setb	%al
               	movzbq	%al, %rax
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x4f802666, %eax       # imm = 0x4F802666
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	seta	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rdi
               	cvtss2sd	%xmm0, %xmm0
               	movb	$0x1, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x4, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movl	$0x406ccccd, %eax       # imm = 0x406CCCCD
               	movq	%rax, %xmm14
               	movss	%xmm14, -0x48(%rbp,%riz)
               	movss	-0x48(%rbp,%riz), %xmm0
               	cvttss2si	%xmm0, %rax
               	movslq	%eax, %rcx
               	cmpq	$0x3, %rcx
               	je	<addr>
               	leaq	<rip>, %rdi
               	movslq	%eax, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x5, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x4007333333333333, %rax # imm = 0x4007333333333333
               	movq	%rax, %xmm0
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	cvttsd2si	%xmm0, %rax
               	movslq	%eax, %rcx
               	cmpq	$-0x2, %rcx
               	je	<addr>
               	leaq	<rip>, %rdi
               	movslq	%eax, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x6, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	addb	%al, (%rax)
