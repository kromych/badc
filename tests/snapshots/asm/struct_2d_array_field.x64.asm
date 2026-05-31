
struct_2d_array_field.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400247 <.text+0x17>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100d0
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	xorq	%r11, %r11
               	movl	%r11d, -0x38(%rbp)
               	jmp	0x40025e <.text+0x2e>
               	movslq	-0x38(%rbp), %r11
               	cmpq	$0x3, %r11
               	jge	0x400299 <.text+0x69>
               	jmp	0x40028d <.text+0x5d>
               	leaq	-0x38(%rbp), %r11
               	movslq	(%r11), %r9
               	movq	%r9, %r8
               	addq	$0x1, %r8
               	movl	%r8d, (%r11)
               	jmp	0x40025e <.text+0x2e>
               	xorq	%r8, %r8
               	movl	%r8d, -0x40(%rbp)
               	jmp	0x4002ad <.text+0x7d>
               	leaq	-0x30(%rbp), %r9
               	xorq	%r11, %r11
               	movl	%r11d, -0x50(%rbp)
               	movl	%r11d, -0x38(%rbp)
               	jmp	0x400325 <.text+0xf5>
               	movslq	-0x40(%rbp), %r8
               	cmpq	$0x4, %r8
               	jge	0x400320 <.text+0xf0>
               	jmp	0x4002dc <.text+0xac>
               	leaq	-0x40(%rbp), %r8
               	movslq	(%r8), %r9
               	movq	%r9, %r11
               	addq	$0x1, %r11
               	movl	%r11d, (%r8)
               	jmp	0x4002ad <.text+0x7d>
               	leaq	-0x30(%rbp), %r11
               	movslq	-0x38(%rbp), %r9
               	movq	%r9, %r8
               	shlq	$0x4, %r8
               	movq	%r11, %rdi
               	addq	%r8, %rdi
               	movslq	-0x40(%rbp), %r8
               	movq	%r8, %r11
               	shlq	$0x2, %r11
               	movq	%rdi, %rsi
               	addq	%r11, %rsi
               	movl	$0xa, %r11d
               	imulq	%r9, %r11
               	movslq	%r11d, %r11
               	movq	%r11, %r9
               	addq	%r8, %r9
               	movslq	%r9d, %r9
               	movl	%r9d, (%rsi)
               	jmp	0x4002c3 <.text+0x93>
               	jmp	0x400274 <.text+0x44>
               	movslq	-0x38(%rbp), %r11
               	cmpq	$0x3, %r11
               	jge	0x400360 <.text+0x130>
               	jmp	0x400354 <.text+0x124>
               	leaq	-0x38(%rbp), %r11
               	movslq	(%r11), %rsi
               	movq	%rsi, %r8
               	addq	$0x1, %r8
               	movl	%r8d, (%r11)
               	jmp	0x400325 <.text+0xf5>
               	xorq	%r8, %r8
               	movl	%r8d, -0x40(%rbp)
               	jmp	0x40037a <.text+0x14a>
               	movslq	-0x50(%rbp), %rdi
               	movq	%rdi, %rdx
               	subq	$0x6f, %rdx
               	movslq	%edx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movslq	-0x40(%rbp), %r8
               	cmpq	$0x4, %r8
               	jge	0x4003e3 <.text+0x1b3>
               	jmp	0x4003a9 <.text+0x179>
               	leaq	-0x40(%rbp), %r8
               	movslq	(%r8), %rsi
               	movq	%rsi, %r11
               	addq	$0x1, %r11
               	movl	%r11d, (%r8)
               	jmp	0x40037a <.text+0x14a>
               	leaq	-0x50(%rbp), %r11
               	movslq	(%r11), %rsi
               	movslq	-0x38(%rbp), %r8
               	movq	%r8, %rdi
               	shlq	$0x4, %rdi
               	movq	%r9, %r8
               	addq	%rdi, %r8
               	movslq	-0x40(%rbp), %rdi
               	movq	%rdi, %rdx
               	shlq	$0x2, %rdx
               	movq	%r8, %rdi
               	addq	%rdx, %rdi
               	movslq	(%rdi), %rdx
               	movq	%rsi, %rdi
               	addq	%rdx, %rdi
               	movl	%edi, (%r11)
               	jmp	0x400390 <.text+0x160>
               	jmp	0x40033b <.text+0x10b>
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
               	orb	(%r9), %cl
               	jbe	0x400423 <.text+0x1f3>
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
               	jae	0x4004aa <.text+0x27a>
               	<unknown>
               	orb	(%rcx), %cl
               	jb	0x4004a1 <.text+0x271>
               	insl	%dx, %es:(%rdi)
               	outsl	(%rsi), %dx
               	je	0x4004a5 <.text+0x275>
               	andb	%ch, 0x74(%rax)
               	je	0x4004b5 <.text+0x285>
               	jae	0x400481 <.text+0x251>
               	<unknown>
               	<unknown>
               	imull	$0x6f632e62, 0x75(%eax,%ebp,2), %esi # imm = 0x6F632E62
               	insl	%dx, %es:(%rdi)
               	<unknown>
               	imull	$0x6d, 0x6f(%rdx), %esi
               	jns	0x4004bd <.text+0x28d>
               	pushq	$0x6461622f             # imm = 0x6461622F
               	movslq	(%rsi), %ebp
               	imull	$0x89485500, (%eax,%eax), %esi # imm = 0x89485500
               	inl	$0x48, %eax
               	subl	$0x10, %esp
               	movq	%rbx, (%rsp)
               	movslq	%edi, %rbx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	0x400527 <exit>
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
               	jbe	0x4004db <.text+0x2ab>
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
               	jae	0x400562 <exit+0x3b>
               	<unknown>
               	orb	(%rcx), %cl
               	jb	0x400559 <exit+0x32>
               	insl	%dx, %es:(%rdi)
               	outsl	(%rsi), %dx
               	je	0x40055d <exit+0x36>
               	andb	%ch, 0x74(%rax)
               	je	0x40056d <exit+0x46>
               	jae	0x400539 <exit+0x12>
               	<unknown>
               	<unknown>
               	imull	$0x6f632e62, 0x75(%eax,%ebp,2), %esi # imm = 0x6F632E62
               	insl	%dx, %es:(%rdi)
               	<unknown>
               	imull	$0x6d, 0x6f(%rdx), %esi
               	jns	0x400575 <exit+0x4e>
               	pushq	$0x6461622f             # imm = 0x6461622F
               	movslq	(%rsi), %ebp
               	imull	$0x0, (%eax,%eax), %esi
               	addb	%al, (%rax)
               	addb	%al, (%rax)
               	addb	%bh, %bh

<exit>:
               	jmpq	*0xfba3(%rip)           # 0x4100d0
