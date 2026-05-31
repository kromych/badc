
mem2reg_value_across_call.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400317 <.text+0xf7>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	movq	%rdi, %r11
               	movq	%r11, %rax
               	addq	$0x7, %rax
               	retq
               	movq	%rdi, %r11
               	movq	%r11, %r9
               	shlq	$0x1, %r9
               	movq	%r9, %rax
               	addq	$0x1, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movq	%rdi, %rbx
               	leaq	-0x4b(%rip), %r12       # 0x400237 <.text+0x17>
               	xorq	%r8, %r8
               	movq	%r8, -0x10(%rbp)
               	movq	%r8, -0x18(%rbp)
               	jmp	0x400292 <.text+0x72>
               	movq	-0x18(%rbp), %r8
               	cmpq	%rbx, %r8
               	jge	0x4002f1 <.text+0xd1>
               	movq	-0x10(%rbp), %r14
               	movq	-0x18(%rbp), %r15
               	movq	%r15, %rdi
               	callq	0x400245 <.text+0x25>
               	movq	%rax, %rsi
               	movq	%r14, %r15
               	addq	%rsi, %r15
               	movq	%r15, -0x10(%rbp)
               	movq	-0x10(%rbp), %r14
               	movq	-0x18(%rbp), %r15
               	movq	%r12, %r11
               	movq	%r15, %rdi
               	callq	*%r11
               	movq	%rax, %rsi
               	movq	%r14, %r15
               	addq	%rsi, %r15
               	movq	%r15, -0x10(%rbp)
               	movq	-0x18(%rbp), %rsi
               	movq	%rsi, %r15
               	addq	$0x1, %r15
               	movq	%r15, -0x18(%rbp)
               	jmp	0x400292 <.text+0x72>
               	movq	-0x10(%rbp), %r15
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movl	$0x3, %ebx
               	movq	%rbx, %rdi
               	callq	0x40025a <.text+0x3a>
               	movq	%rax, %r9
               	movq	%r9, %rbx
               	andq	$0x7f, %rbx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	orb	(%r9), %cl
               	jbe	0x40038b <.text+0x16b>
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
               	jae	0x400412 <.text+0x1f2>
               	<unknown>
               	orb	(%rcx), %cl
               	jb	0x400409 <.text+0x1e9>
               	insl	%dx, %es:(%rdi)
               	outsl	(%rsi), %dx
               	je	0x40040d <.text+0x1ed>
               	andb	%ch, 0x74(%rax)
               	je	0x40041d <.text+0x1fd>
               	jae	0x4003e9 <.text+0x1c9>
               	<unknown>
               	<unknown>
               	imull	$0x6f632e62, 0x75(%eax,%ebp,2), %esi # imm = 0x6F632E62
               	insl	%dx, %es:(%rdi)
               	<unknown>
               	imull	$0x6d, 0x6f(%rdx), %esi
               	jns	0x400425 <.text+0x205>
               	pushq	$0x6461622f             # imm = 0x6461622F
               	movslq	(%rsi), %ebp
               	imull	$0x0, (%eax,%eax), %esi
               	addb	%al, (%rax)
               	addb	%al, (%rax)
               	addb	%dl, 0x48(%rbp)
               	movl	%esp, %ebp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movslq	%edi, %rbx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	0x400497 <exit>
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
               	jbe	0x40044b <.text+0x22b>
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
               	jae	0x4004d2 <exit+0x3b>
               	<unknown>
               	orb	(%rcx), %cl
               	jb	0x4004c9 <exit+0x32>
               	insl	%dx, %es:(%rdi)
               	outsl	(%rsi), %dx
               	je	0x4004cd <exit+0x36>
               	andb	%ch, 0x74(%rax)
               	je	0x4004dd <exit+0x46>
               	jae	0x4004a9 <exit+0x12>
               	<unknown>
               	<unknown>
               	imull	$0x6f632e62, 0x75(%eax,%ebp,2), %esi # imm = 0x6F632E62
               	insl	%dx, %es:(%rdi)
               	<unknown>
               	imull	$0x6d, 0x6f(%rdx), %esi
               	jns	0x4004e5 <exit+0x4e>
               	pushq	$0x6461622f             # imm = 0x6461622F
               	movslq	(%rsi), %ebp
               	imull	$0x0, (%eax,%eax), %esi
               	addb	%al, (%rax)
               	addb	%al, (%rax)
               	addb	%bh, %bh

<exit>:
               	jmpq	*0xfc23(%rip)           # 0x4100c0
