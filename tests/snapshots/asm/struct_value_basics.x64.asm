
struct_value_basics.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400237 <.text+0x17>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	-0x8(%rbp), %r11
               	movl	$0x3, %r9d
               	movl	%r9d, (%r11)
               	leaq	-0x8(%rbp), %r8
               	movq	%r8, %r9
               	addq	$0x4, %r9
               	movl	$0x4, %r8d
               	movl	%r8d, (%r9)
               	leaq	-0x8(%rbp), %r11
               	movslq	(%r11), %r8
               	cmpq	$0x3, %r8
               	je	0x400288 <.text+0x68>
               	movl	$0x1, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %r11
               	movq	%r11, %rax
               	addq	$0x4, %rax
               	movslq	(%rax), %r11
               	cmpq	$0x4, %r11
               	je	0x4002b8 <.text+0x98>
               	movl	$0x2, %r11d
               	movq	%r11, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movslq	(%rax), %r11
               	cmpq	$0x3, %r11
               	je	0x4002de <.text+0xbe>
               	movl	$0x3, %r11d
               	movq	%r11, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	%rax, %r9
               	addq	$0x4, %r9
               	movslq	(%r9), %r11
               	cmpq	$0x4, %r11
               	je	0x40030a <.text+0xea>
               	movl	$0x4, %r11d
               	movq	%r11, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1e, %r9d
               	movl	%r9d, (%rax)
               	movq	%rax, %r11
               	addq	$0x4, %r11
               	movl	$0x28, %eax
               	movl	%eax, (%r11)
               	leaq	-0x8(%rbp), %r9
               	movslq	(%r9), %rax
               	cmpq	$0x1e, %rax
               	je	0x400347 <.text+0x127>
               	movl	$0x5, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %r9
               	movq	%r9, %rax
               	addq	$0x4, %rax
               	movslq	(%rax), %r9
               	cmpq	$0x28, %r9
               	je	0x400377 <.text+0x157>
               	movl	$0x6, %r9d
               	movq	%r9, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movl	$0x64, %r9d
               	movl	%r9d, (%rax)
               	leaq	-0x10(%rbp), %r11
               	movq	%r11, %r9
               	addq	$0x4, %r9
               	movl	$0xc8, %r11d
               	movl	%r11d, (%r9)
               	leaq	-0x8(%rbp), %rax
               	movslq	(%rax), %r11
               	cmpq	$0x1e, %r11
               	je	0x4003c1 <.text+0x1a1>
               	movl	$0x7, %r11d
               	movq	%r11, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movslq	(%rax), %r11
               	cmpq	$0x64, %r11
               	je	0x4003e7 <.text+0x1c7>
               	movl	$0x8, %r11d
               	movq	%r11, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movslq	(%rax), %r11
               	leaq	-0x8(%rbp), %rax
               	movq	%rax, %r9
               	addq	$0x4, %r9
               	movslq	(%r9), %rax
               	movq	%r11, %r9
               	addq	%rax, %r9
               	movslq	%r9d, %r9
               	leaq	-0x10(%rbp), %rax
               	movslq	(%rax), %r11
               	movq	%r9, %rax
               	addq	%r11, %rax
               	movslq	%eax, %rax
               	leaq	-0x10(%rbp), %r11
               	movq	%r11, %r9
               	addq	$0x4, %r9
               	movslq	(%r9), %r11
               	movq	%rax, %r9
               	addq	%r11, %r9
               	movslq	%r9d, %r9
               	movslq	%r9d, %r11
               	cmpq	$0x172, %r11            # imm = 0x172
               	je	0x400450 <.text+0x230>
               	movl	$0x9, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%r9, %r9
               	movq	%r9, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	orb	(%r9), %cl
               	jbe	0x400497 <.text+0x277>
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
               	jae	0x40051e <.text+0x2fe>
               	<unknown>
               	orb	(%rcx), %cl
               	jb	0x400515 <.text+0x2f5>
               	insl	%dx, %es:(%rdi)
               	outsl	(%rsi), %dx
               	je	0x400519 <.text+0x2f9>
               	andb	%ch, 0x74(%rax)
               	je	0x400529 <.text+0x309>
               	jae	0x4004f5 <.text+0x2d5>
               	<unknown>
               	<unknown>
               	imull	$0x6f632e62, 0x75(%eax,%ebp,2), %esi # imm = 0x6F632E62
               	insl	%dx, %es:(%rdi)
               	<unknown>
               	imull	$0x6d, 0x6f(%rdx), %esi
               	jns	0x400531 <.text+0x311>
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
               	callq	0x4005a7 <exit>
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
               	jbe	0x40055b <.text+0x33b>
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
               	jae	0x4005e2 <exit+0x3b>
               	<unknown>
               	orb	(%rcx), %cl
               	jb	0x4005d9 <exit+0x32>
               	insl	%dx, %es:(%rdi)
               	outsl	(%rsi), %dx
               	je	0x4005dd <exit+0x36>
               	andb	%ch, 0x74(%rax)
               	je	0x4005ed <exit+0x46>
               	jae	0x4005b9 <exit+0x12>
               	<unknown>
               	<unknown>
               	imull	$0x6f632e62, 0x75(%eax,%ebp,2), %esi # imm = 0x6F632E62
               	insl	%dx, %es:(%rdi)
               	<unknown>
               	imull	$0x6d, 0x6f(%rdx), %esi
               	jns	0x4005f5 <exit+0x4e>
               	pushq	$0x6461622f             # imm = 0x6461622F
               	movslq	(%rsi), %ebp
               	imull	$0x0, (%eax,%eax), %esi
               	addb	%al, (%rax)
               	addb	%al, (%rax)
               	addb	%bh, %bh

<exit>:
               	jmpq	*0xfb13(%rip)           # 0x4100c0
