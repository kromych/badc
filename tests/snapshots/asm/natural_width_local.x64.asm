
natural_width_local.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400237 <.text+0x17>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movl	$0x12c, %r11d           # imm = 0x12C
               	movl	$0xc8, %r9d
               	xorq	%r8, %r8
               	movl	%r8d, -0x20(%rbp)
               	movl	%r8d, -0x28(%rbp)
               	jmp	0x40025e <.text+0x3e>
               	movslq	-0x20(%rbp), %r8
               	cmpq	$0x4, %r8
               	jge	0x40029c <.text+0x7c>
               	movslq	-0x28(%rbp), %r8
               	movsbq	%r11b, %rdi
               	movq	%r8, %rsi
               	addq	%rdi, %rsi
               	movslq	%esi, %rsi
               	movl	%esi, -0x28(%rbp)
               	movslq	-0x20(%rbp), %rdi
               	movq	%rdi, %rsi
               	addq	$0x1, %rsi
               	movslq	%esi, %rsi
               	movl	%esi, -0x20(%rbp)
               	jmp	0x40025e <.text+0x3e>
               	xorq	%rsi, %rsi
               	movl	%esi, -0x30(%rbp)
               	movsbq	%r11b, %rdi
               	cmpq	$0x2c, %rdi
               	je	0x4002cc <.text+0xac>
               	movslq	-0x30(%rbp), %rdi
               	movq	%rdi, %rsi
               	addq	$0x1, %rsi
               	movslq	%esi, %rsi
               	movl	%esi, -0x30(%rbp)
               	jmp	0x4002cc <.text+0xac>
               	movq	%r11, %rsi
               	andq	$0xff, %rsi
               	movq	%rsi, %rdi
               	xorq	$0x2c, %rdi
               	movl	$0xffffffff, %esi       # imm = 0xFFFFFFFF
               	andq	%rdi, %rsi
               	cmpq	$0x0, %rsi
               	je	0x40030e <.text+0xee>
               	movslq	-0x30(%rbp), %rsi
               	movq	%rsi, %rdi
               	addq	$0x2, %rdi
               	movslq	%edi, %rdi
               	movl	%edi, -0x30(%rbp)
               	jmp	0x40030e <.text+0xee>
               	movsbq	%r9b, %rdi
               	cmpq	$-0x38, %rdi
               	je	0x400338 <.text+0x118>
               	movslq	-0x30(%rbp), %rdi
               	movq	%rdi, %rsi
               	addq	$0x4, %rsi
               	movslq	%esi, %rsi
               	movl	%esi, -0x30(%rbp)
               	jmp	0x400338 <.text+0x118>
               	movslq	-0x28(%rbp), %rsi
               	cmpq	$0xb0, %rsi
               	je	0x400362 <.text+0x142>
               	movslq	-0x30(%rbp), %rsi
               	movq	%rsi, %rdi
               	addq	$0x8, %rdi
               	movslq	%edi, %rdi
               	movl	%edi, -0x30(%rbp)
               	jmp	0x400362 <.text+0x142>
               	movslq	-0x30(%rbp), %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	orb	(%r9), %cl
               	jbe	0x4003a7 <.text+0x187>
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
               	jae	0x40042e <.text+0x20e>
               	<unknown>
               	orb	(%rcx), %cl
               	jb	0x400425 <.text+0x205>
               	insl	%dx, %es:(%rdi)
               	outsl	(%rsi), %dx
               	je	0x400429 <.text+0x209>
               	andb	%ch, 0x74(%rax)
               	je	0x400439 <.text+0x219>
               	jae	0x400405 <.text+0x1e5>
               	<unknown>
               	<unknown>
               	imull	$0x6f632e62, 0x75(%eax,%ebp,2), %esi # imm = 0x6F632E62
               	insl	%dx, %es:(%rdi)
               	<unknown>
               	imull	$0x6d, 0x6f(%rdx), %esi
               	jns	0x400441 <.text+0x221>
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
               	callq	0x4004b7 <exit>
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
               	jbe	0x40046b <.text+0x24b>
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
               	jae	0x4004f2 <exit+0x3b>
               	<unknown>
               	orb	(%rcx), %cl
               	jb	0x4004e9 <exit+0x32>
               	insl	%dx, %es:(%rdi)
               	outsl	(%rsi), %dx
               	je	0x4004ed <exit+0x36>
               	andb	%ch, 0x74(%rax)
               	je	0x4004fd <exit+0x46>
               	jae	0x4004c9 <exit+0x12>
               	<unknown>
               	<unknown>
               	imull	$0x6f632e62, 0x75(%eax,%ebp,2), %esi # imm = 0x6F632E62
               	insl	%dx, %es:(%rdi)
               	<unknown>
               	imull	$0x6d, 0x6f(%rdx), %esi
               	jns	0x400505 <exit+0x4e>
               	pushq	$0x6461622f             # imm = 0x6461622F
               	movslq	(%rsi), %ebp
               	imull	$0x0, (%eax,%eax), %esi
               	addb	%al, (%rax)
               	addb	%al, (%rax)
               	addb	%bh, %bh

<exit>:
               	jmpq	*0xfc03(%rip)           # 0x4100c0
