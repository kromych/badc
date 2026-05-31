
integer_literal_suffix.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400237 <.text+0x17>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movabsq	$0x1000000000, %r11     # imm = 0x1000000000
               	movq	%r11, %r9
               	subq	$0x1, %r9
               	movabsq	$0xfffffffff, %r10      # imm = 0xFFFFFFFFF
               	movq	%r9, %r11
               	cmpq	%r10, %r9
               	je	0x40027a <.text+0x5a>
               	movl	$0xb, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	$0x24, %r11d
               	movl	$0x1, %eax
               	movslq	%r11d, %r8
               	movq	%rax, %r11
               	movq	%r8, %rcx
               	shlq	%cl, %r11
               	movq	%r11, %r8
               	subq	$0x1, %r8
               	movabsq	$0xfffffffff, %r10      # imm = 0xFFFFFFFFF
               	movq	%r8, %r11
               	cmpq	%r10, %r8
               	je	0x4002bf <.text+0x9f>
               	movl	$0xc, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x123456789, %r11      # imm = 0x123456789
               	movq	%r11, %rax
               	addq	$0x1, %rax
               	movabsq	$0x12345678a, %r10      # imm = 0x12345678A
               	movq	%rax, %r11
               	cmpq	%r10, %rax
               	je	0x4002f7 <.text+0xd7>
               	movl	$0xd, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movabsq	$-0x1, %r11
               	cmpq	$-0x1, %r11
               	sete	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x40(%rbp)
               	cmpq	$0x0, %rax
               	je	0x40033e <.text+0x11e>
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	movq	%r11, %r8
               	cmpq	%r10, %r11
               	sete	%r8b
               	movzbq	%r8b, %r8
               	movq	%r8, -0x40(%rbp)
               	jmp	0x40033e <.text+0x11e>
               	movq	-0x40(%rbp), %r8
               	cmpq	$0x0, %r8
               	je	0x40035d <.text+0x13d>
               	movl	$0xe, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	cmpq	$-0x1, %r11
               	je	0x400378 <.text+0x158>
               	movl	$0xf, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movabsq	$-0x1, %r8
               	movq	%r8, %rax
               	addq	$0x1, %rax
               	cmpq	$0x0, %rax
               	je	0x4003a7 <.text+0x187>
               	movl	$0x10, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%r8, %r8
               	movq	%r8, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
               	orb	(%r9), %cl
               	jbe	0x4003ef <.text+0x1cf>
               	xorb	%ch, %cs:(%rsi)
               	cmpb	%cl, (%rdx)
               	orl	%esp, 0x6f(%rbx)
               	insl	%dx, %es:(%rdi)
               	insl	%dx, %es:(%rdi)
               	imull	$0x37313633, 0x32(%rax,%riz), %esi # imm = 0x37313633
               	xorw	(%rdi), %si
               	movslq	0x61(%rbp), %esp
               	xorl	$0x32613735, %eax       # imm = 0x32613735
               	xorl	$0x35363734, %eax       # imm = 0x35363734
               	xorl	$0x31306335, %eax       # imm = 0x31306335
               	<unknown>
               	xorl	$0x38323965, %eax       # imm = 0x38323965
               	movslq	(%rdx), %esi
               	<unknown>
               	xorl	%esi, (%rsi)
               	orb	(%rcx), %cl
               	<unknown>
               	movslq	0x67(%rsi), %esp
               	popq	%rdi
               	jae	0x400476 <.text+0x256>
               	<unknown>
               	orb	(%rcx), %cl
               	jb	0x40046d <.text+0x24d>
               	insl	%dx, %es:(%rdi)
               	outsl	(%rsi), %dx
               	je	0x400471 <.text+0x251>
               	andb	%ch, 0x74(%rax)
               	je	0x400481 <.text+0x261>
               	jae	0x40044d <.text+0x22d>
               	<unknown>
               	<unknown>
               	imull	$0x6f632e62, 0x75(%eax,%ebp,2), %esi # imm = 0x6F632E62
               	insl	%dx, %es:(%rdi)
               	<unknown>
               	imull	$0x6d, 0x6f(%rdx), %esi
               	jns	0x400489 <.text+0x269>
               	pushq	$0x6461622f             # imm = 0x6461622F
               	movslq	(%rsi), %ebp
               	imull	$0x0, (%eax,%eax), %esi
               	addb	%dl, 0x48(%rbp)
               	movl	%esp, %ebp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movslq	%edi, %rbx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	0x4004f7 <exit>
               	movzbq	%al, %rax
               	movq	%rax, %r9
               	xorq	%r9, %r9
               	movq	%r9, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
               	orb	(%r9), %cl
               	jbe	0x4004ab <.text+0x28b>
               	xorb	%ch, %cs:(%rsi)
               	cmpb	%cl, (%rdx)
               	orl	%esp, 0x6f(%rbx)
               	insl	%dx, %es:(%rdi)
               	insl	%dx, %es:(%rdi)
               	imull	$0x37313633, 0x32(%rax,%riz), %esi # imm = 0x37313633
               	xorw	(%rdi), %si
               	movslq	0x61(%rbp), %esp
               	xorl	$0x32613735, %eax       # imm = 0x32613735
               	xorl	$0x35363734, %eax       # imm = 0x35363734
               	xorl	$0x31306335, %eax       # imm = 0x31306335
               	<unknown>
               	xorl	$0x38323965, %eax       # imm = 0x38323965
               	movslq	(%rdx), %esi
               	<unknown>
               	xorl	%esi, (%rsi)
               	orb	(%rcx), %cl
               	<unknown>
               	movslq	0x67(%rsi), %esp
               	popq	%rdi
               	jae	0x400532 <exit+0x3b>
               	<unknown>
               	orb	(%rcx), %cl
               	jb	0x400529 <exit+0x32>
               	insl	%dx, %es:(%rdi)
               	outsl	(%rsi), %dx
               	je	0x40052d <exit+0x36>
               	andb	%ch, 0x74(%rax)
               	je	0x40053d <exit+0x46>
               	jae	0x400509 <exit+0x12>
               	<unknown>
               	<unknown>
               	imull	$0x6f632e62, 0x75(%eax,%ebp,2), %esi # imm = 0x6F632E62
               	insl	%dx, %es:(%rdi)
               	<unknown>
               	imull	$0x6d, 0x6f(%rdx), %esi
               	jns	0x400545 <exit+0x4e>
               	pushq	$0x6461622f             # imm = 0x6461622F
               	movslq	(%rsi), %ebp
               	imull	$0x0, (%eax,%eax), %esi
               	addb	%al, (%rax)
               	addb	%al, (%rax)
               	addb	%bh, %bh

<exit>:
               	jmpq	*0xfbc3(%rip)           # 0x4100c0
