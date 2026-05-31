
static_linked_list.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400247 <.text+0x17>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100d0
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	0xfe87(%rip), %r11      # 0x4100e0
               	movl	$0x1, %r9d
               	movl	%r9d, (%r11)
               	movq	%r11, %r8
               	addq	$0x8, %r8
               	leaq	0xfe7d(%rip), %r11      # 0x4100f0
               	movq	%r11, (%r8)
               	movl	$0x2, %r9d
               	movl	%r9d, (%r11)
               	movq	%r11, %r8
               	addq	$0x8, %r8
               	leaq	0xfe70(%rip), %r11      # 0x410100
               	movq	%r11, (%r8)
               	movl	$0x3, %r9d
               	movl	%r9d, (%r11)
               	movq	%r11, %r8
               	addq	$0x8, %r8
               	xorq	%r11, %r11
               	movq	%r11, (%r8)
               	movl	%r11d, -0x8(%rbp)
               	leaq	0xfe59(%rip), %r9       # 0x410110
               	movq	(%r9), %r11
               	movq	%r11, -0x10(%rbp)
               	jmp	0x4002c3 <.text+0x93>
               	movq	-0x10(%rbp), %r11
               	cmpq	$0x0, %r11
               	je	0x400301 <.text+0xd1>
               	movslq	-0x8(%rbp), %r11
               	movq	-0x10(%rbp), %r9
               	movslq	(%r9), %r8
               	movq	%r11, %rdi
               	addq	%r8, %rdi
               	movslq	%edi, %rdi
               	movl	%edi, -0x8(%rbp)
               	movq	%r9, %r8
               	addq	$0x8, %r8
               	movq	(%r8), %r9
               	movq	%r9, -0x10(%rbp)
               	jmp	0x4002c3 <.text+0x93>
               	movslq	-0x8(%rbp), %r9
               	cmpq	$0x6, %r9
               	je	0x400320 <.text+0xf0>
               	movl	$0x1, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%r8, %r8
               	movq	%r8, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	orb	(%r9), %cl
               	jbe	0x400367 <.text+0x137>
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
               	jae	0x4003ee <.text+0x1be>
               	<unknown>
               	orb	(%rcx), %cl
               	jb	0x4003e5 <.text+0x1b5>
               	insl	%dx, %es:(%rdi)
               	outsl	(%rsi), %dx
               	je	0x4003e9 <.text+0x1b9>
               	andb	%ch, 0x74(%rax)
               	je	0x4003f9 <.text+0x1c9>
               	jae	0x4003c5 <.text+0x195>
               	<unknown>
               	<unknown>
               	imull	$0x6f632e62, 0x75(%eax,%ebp,2), %esi # imm = 0x6F632E62
               	insl	%dx, %es:(%rdi)
               	<unknown>
               	imull	$0x6d, 0x6f(%rdx), %esi
               	jns	0x400401 <.text+0x1d1>
               	pushq	$0x6461622f             # imm = 0x6461622F
               	movslq	(%rsi), %ebp
               	imull	$0x0, (%eax,%eax), %esi
		...
               	addb	%dl, 0x48(%rbp)
               	movl	%esp, %ebp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movslq	%edi, %rbx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	0x400477 <exit>
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
               	jbe	0x40042b <.text+0x1fb>
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
               	jae	0x4004b2 <exit+0x3b>
               	<unknown>
               	orb	(%rcx), %cl
               	jb	0x4004a9 <exit+0x32>
               	insl	%dx, %es:(%rdi)
               	outsl	(%rsi), %dx
               	je	0x4004ad <exit+0x36>
               	andb	%ch, 0x74(%rax)
               	je	0x4004bd <exit+0x46>
               	jae	0x400489 <exit+0x12>
               	<unknown>
               	<unknown>
               	imull	$0x6f632e62, 0x75(%eax,%ebp,2), %esi # imm = 0x6F632E62
               	insl	%dx, %es:(%rdi)
               	<unknown>
               	imull	$0x6d, 0x6f(%rdx), %esi
               	jns	0x4004c5 <exit+0x4e>
               	pushq	$0x6461622f             # imm = 0x6461622F
               	movslq	(%rsi), %ebp
               	imull	$0x0, (%eax,%eax), %esi
               	addb	%al, (%rax)
               	addb	%al, (%rax)
               	addb	%bh, %bh

<exit>:
               	jmpq	*0xfc53(%rip)           # 0x4100d0
