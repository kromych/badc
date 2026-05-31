
const_expr_conditional.x64:	file format elf64-x86-64

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
               	leaq	-0x10(%rbp), %r11
               	movl	$0x5, %r9d
               	movl	%r9d, (%r11)
               	leaq	-0x10(%rbp), %r8
               	movq	%r8, %r9
               	addq	$0x4, %r9
               	movl	$0x7, %r8d
               	movl	%r8d, (%r9)
               	leaq	-0x10(%rbp), %r11
               	movq	%r11, %r8
               	addq	$0x8, %r8
               	movl	$0xe, %r11d
               	movl	%r11d, (%r8)
               	leaq	-0x10(%rbp), %r9
               	movq	%r9, %r11
               	addq	$0xc, %r11
               	movl	$0x1, %r9d
               	movl	%r9d, (%r11)
               	leaq	-0x10(%rbp), %r8
               	movslq	(%r8), %r9
               	leaq	-0x10(%rbp), %r8
               	movq	%r8, %r11
               	addq	$0x4, %r11
               	movslq	(%r11), %r8
               	movq	%r9, %r11
               	addq	%r8, %r11
               	movslq	%r11d, %r11
               	leaq	-0x10(%rbp), %r8
               	movq	%r8, %r9
               	addq	$0x8, %r9
               	movslq	(%r9), %r8
               	movq	%r11, %r9
               	addq	%r8, %r9
               	movslq	%r9d, %r9
               	leaq	-0x10(%rbp), %r8
               	movq	%r8, %r11
               	addq	$0xc, %r11
               	movslq	(%r11), %r8
               	movq	%r9, %r11
               	addq	%r8, %r11
               	movslq	%r11d, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
               	orb	(%r9), %cl
               	jbe	0x40033b <.text+0x10b>
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
               	jae	0x4003c2 <.text+0x192>
               	<unknown>
               	orb	(%rcx), %cl
               	jb	0x4003b9 <.text+0x189>
               	insl	%dx, %es:(%rdi)
               	outsl	(%rsi), %dx
               	je	0x4003bd <.text+0x18d>
               	andb	%ch, 0x74(%rax)
               	je	0x4003cd <.text+0x19d>
               	jae	0x400399 <.text+0x169>
               	<unknown>
               	<unknown>
               	imull	$0x6f632e62, 0x75(%eax,%ebp,2), %esi # imm = 0x6F632E62
               	insl	%dx, %es:(%rdi)
               	<unknown>
               	imull	$0x6d, 0x6f(%rdx), %esi
               	jns	0x4003d5 <.text+0x1a5>
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
               	callq	0x400447 <exit>
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
               	jbe	0x4003fb <.text+0x1cb>
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
               	jae	0x400482 <exit+0x3b>
               	<unknown>
               	orb	(%rcx), %cl
               	jb	0x400479 <exit+0x32>
               	insl	%dx, %es:(%rdi)
               	outsl	(%rsi), %dx
               	je	0x40047d <exit+0x36>
               	andb	%ch, 0x74(%rax)
               	je	0x40048d <exit+0x46>
               	jae	0x400459 <exit+0x12>
               	<unknown>
               	<unknown>
               	imull	$0x6f632e62, 0x75(%eax,%ebp,2), %esi # imm = 0x6F632E62
               	insl	%dx, %es:(%rdi)
               	<unknown>
               	imull	$0x6d, 0x6f(%rdx), %esi
               	jns	0x400495 <exit+0x4e>
               	pushq	$0x6461622f             # imm = 0x6461622F
               	movslq	(%rsi), %ebp
               	imull	$0x0, (%eax,%eax), %esi
               	addb	%al, (%rax)
               	addb	%al, (%rax)
               	addb	%bh, %bh

<exit>:
               	jmpq	*0xfc83(%rip)           # 0x4100d0
