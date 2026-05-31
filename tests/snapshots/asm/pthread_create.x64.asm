
pthread_create.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x4002d0 <.text+0x20>
               	movq	%rax, %rdi
               	callq	*0xfe19(%rip)           # 0x4100e0
               	movq	%rdi, %r11
               	movl	$0xb, %eax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x80, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	xorq	%rbx, %rbx
               	movl	$0x2, %r12d
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	xorl	%eax, %eax
               	callq	0x4004d7 <dlopen>
               	movq	%rax, %r14
               	leaq	0xfdea(%rip), %r15      # 0x4100f8
               	movq	%r14, %rdi
               	movq	%r15, %rsi
               	xorl	%eax, %eax
               	callq	0x4004dd <dlsym>
               	movq	%rax, %r10
               	movq	%r10, 0x28(%rsp)
               	leaq	0xfddd(%rip), %r15      # 0x410107
               	movq	%r14, %rdi
               	movq	%r15, %rsi
               	xorl	%eax, %eax
               	callq	0x4004dd <dlsym>
               	movq	%rax, %r12
               	leaq	-0x20(%rbp), %r14
               	leaq	-0x7e(%rip), %r15       # 0x4002c7 <.text+0x17>
               	movq	0x28(%rsp), %r11
               	movq	%r14, %rdi
               	movq	%rbx, %rcx
               	movq	%r15, %rdx
               	movq	%rbx, %rsi
               	callq	*%r11
               	movq	%rax, %rsi
               	movq	-0x20(%rbp), %rbx
               	leaq	-0x28(%rbp), %r14
               	movq	%r12, %r11
               	movq	%rbx, %rdi
               	movq	%r14, %rsi
               	callq	*%r11
               	movq	%rax, %r15
               	movq	-0x28(%rbp), %r15
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	orb	(%r9), %cl
               	jbe	0x4003d3 <.text+0x123>
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
               	jae	0x40045a <.text+0x1aa>
               	<unknown>
               	orb	(%rcx), %cl
               	jb	0x400451 <.text+0x1a1>
               	insl	%dx, %es:(%rdi)
               	outsl	(%rsi), %dx
               	je	0x400455 <.text+0x1a5>
               	andb	%ch, 0x74(%rax)
               	je	0x400465 <.text+0x1b5>
               	jae	0x400431 <.text+0x181>
               	<unknown>
               	<unknown>
               	imull	$0x6f632e62, 0x75(%eax,%ebp,2), %esi # imm = 0x6F632E62
               	insl	%dx, %es:(%rdi)
               	<unknown>
               	imull	$0x6d, 0x6f(%rdx), %esi
               	jns	0x40046d <.text+0x1bd>
               	pushq	$0x6461622f             # imm = 0x6461622F
               	movslq	(%rsi), %ebp
               	imull	$0x89485500, (%eax,%eax), %esi # imm = 0x89485500
               	inl	$0x48, %eax
               	subl	$0x10, %esp
               	movq	%rbx, (%rsp)
               	movslq	%edi, %rbx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	0x4004e3 <exit>
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
               	jbe	0x40048b <.text+0x1db>
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
               	jae	0x400512 <exit+0x2f>
               	<unknown>
               	orb	(%rcx), %cl
               	jb	0x400509 <exit+0x26>
               	insl	%dx, %es:(%rdi)
               	outsl	(%rsi), %dx
               	je	0x40050d <exit+0x2a>
               	andb	%ch, 0x74(%rax)
               	je	0x40051d <exit+0x3a>
               	jae	0x4004e9 <exit+0x6>
               	<unknown>
               	<unknown>
               	imull	$0x6f632e62, 0x75(%eax,%ebp,2), %esi # imm = 0x6F632E62
               	insl	%dx, %es:(%rdi)
               	<unknown>
               	imull	$0x6d, 0x6f(%rdx), %esi
               	jns	0x400525 <exit+0x42>
               	pushq	$0x6461622f             # imm = 0x6461622F
               	movslq	(%rsi), %ebp
               	imull	$0x0, (%eax,%eax), %esi
               	addb	%al, (%rax)
               	addb	%al, (%rax)
               	addb	%bh, %bh

<dlopen>:
               	jmpq	*0xfbf3(%rip)           # 0x4100d0

<dlsym>:
               	jmpq	*0xfbf5(%rip)           # 0x4100d8

<exit>:
               	jmpq	*0xfbf7(%rip)           # 0x4100e0
