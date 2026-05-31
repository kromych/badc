
typedef_struct_carrier_reset.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x40032d <.text+0x10d>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, %r11
               	xorq	%r9, %r9
               	movl	%r9d, -0x10(%rbp)
               	movl	%r9d, -0x8(%rbp)
               	jmp	0x400255 <.text+0x35>
               	movslq	-0x8(%rbp), %r9
               	cmpq	$0xa, %r9
               	jge	0x400307 <.text+0xe7>
               	jmp	0x400284 <.text+0x64>
               	leaq	-0x8(%rbp), %r9
               	movslq	(%r9), %r8
               	movq	%r8, %rdi
               	addq	$0x1, %rdi
               	movl	%edi, (%r9)
               	jmp	0x400255 <.text+0x35>
               	movslq	-0x8(%rbp), %rdi
               	movq	%rdi, %r8
               	shlq	$0x2, %r8
               	movq	%r11, %r9
               	addq	%r8, %r9
               	movl	%edi, (%r9)
               	movq	%r11, %r8
               	addq	$0x28, %r8
               	movslq	-0x8(%rbp), %r9
               	movq	%r9, %rdi
               	shlq	$0x2, %rdi
               	movq	%r8, %rsi
               	addq	%rdi, %rsi
               	movq	%r9, %rdi
               	addq	$0x1, %rdi
               	movslq	%edi, %rdi
               	movl	%edi, (%rsi)
               	leaq	-0x10(%rbp), %r9
               	movslq	(%r9), %rdi
               	movslq	-0x8(%rbp), %rsi
               	movq	%rsi, %r8
               	shlq	$0x2, %r8
               	movq	%r11, %rsi
               	addq	%r8, %rsi
               	movslq	(%rsi), %rdx
               	movq	%r11, %rsi
               	addq	$0x28, %rsi
               	movq	%rsi, %rcx
               	addq	%r8, %rcx
               	movslq	(%rcx), %rsi
               	movq	%rdx, %rcx
               	addq	%rsi, %rcx
               	movslq	%ecx, %rcx
               	movq	%rdi, %rsi
               	addq	%rcx, %rsi
               	movl	%esi, (%r9)
               	jmp	0x40026b <.text+0x4b>
               	movq	%r11, %rsi
               	addq	$0xa0, %rsi
               	movslq	-0x10(%rbp), %rcx
               	movl	%ecx, (%rsi)
               	movq	%r11, %r9
               	addq	$0xa0, %r9
               	movslq	(%r9), %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xd0, %rsp
               	movq	%rbx, (%rsp)
               	leaq	-0xa8(%rbp), %rbx
               	movq	%rbx, %rdi
               	callq	0x400237 <.text+0x17>
               	movq	%rax, %r9
               	movslq	%r9d, %rbx
               	cmpq	$0x64, %rbx
               	je	0x400376 <.text+0x156>
               	movl	$0x1, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xa8(%rbp), %r9
               	movq	%r9, %rbx
               	addq	$0x14, %rbx
               	movslq	(%rbx), %r9
               	cmpq	$0x5, %r9
               	je	0x4003b0 <.text+0x190>
               	movl	$0x2, %r9d
               	movq	%r9, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xa8(%rbp), %rbx
               	movq	%rbx, %r9
               	addq	$0x3c, %r9
               	movslq	(%r9), %rbx
               	cmpq	$0x6, %rbx
               	je	0x4003e9 <.text+0x1c9>
               	movl	$0x3, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xa8(%rbp), %r9
               	movq	%r9, %rbx
               	addq	$0xa0, %rbx
               	movslq	(%rbx), %r9
               	cmpq	$0x64, %r9
               	je	0x400423 <.text+0x203>
               	movl	$0x4, %r9d
               	movq	%r9, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rbx, %rbx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	orb	(%r9), %cl
               	jbe	0x400473 <.text+0x253>
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
               	jae	0x4004fa <.text+0x2da>
               	<unknown>
               	orb	(%rcx), %cl
               	jb	0x4004f1 <.text+0x2d1>
               	insl	%dx, %es:(%rdi)
               	outsl	(%rsi), %dx
               	je	0x4004f5 <.text+0x2d5>
               	andb	%ch, 0x74(%rax)
               	je	0x400505 <.text+0x2e5>
               	jae	0x4004d1 <.text+0x2b1>
               	<unknown>
               	<unknown>
               	imull	$0x6f632e62, 0x75(%eax,%ebp,2), %esi # imm = 0x6F632E62
               	insl	%dx, %es:(%rdi)
               	<unknown>
               	imull	$0x6d, 0x6f(%rdx), %esi
               	jns	0x40050d <.text+0x2ed>
               	pushq	$0x6461622f             # imm = 0x6461622F
               	movslq	(%rsi), %ebp
               	imull	$0x89485500, (%eax,%eax), %esi # imm = 0x89485500
               	inl	$0x48, %eax
               	subl	$0x10, %esp
               	movq	%rbx, (%rsp)
               	movslq	%edi, %rbx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	0x400577 <exit>
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
               	jbe	0x40052b <.text+0x30b>
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
               	jae	0x4005b2 <exit+0x3b>
               	<unknown>
               	orb	(%rcx), %cl
               	jb	0x4005a9 <exit+0x32>
               	insl	%dx, %es:(%rdi)
               	outsl	(%rsi), %dx
               	je	0x4005ad <exit+0x36>
               	andb	%ch, 0x74(%rax)
               	je	0x4005bd <exit+0x46>
               	jae	0x400589 <exit+0x12>
               	<unknown>
               	<unknown>
               	imull	$0x6f632e62, 0x75(%eax,%ebp,2), %esi # imm = 0x6F632E62
               	insl	%dx, %es:(%rdi)
               	<unknown>
               	imull	$0x6d, 0x6f(%rdx), %esi
               	jns	0x4005c5 <exit+0x4e>
               	pushq	$0x6461622f             # imm = 0x6461622F
               	movslq	(%rsi), %ebp
               	imull	$0x0, (%eax,%eax), %esi
               	addb	%al, (%rax)
               	addb	%al, (%rax)
               	addb	%bh, %bh

<exit>:
               	jmpq	*0xfb43(%rip)           # 0x4100c0
