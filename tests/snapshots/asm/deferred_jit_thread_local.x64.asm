
deferred_jit_thread_local.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x4002b2 <.text+0x42>
               	movq	%rax, %rdi
               	callq	*0xfe49(%rip)           # 0x4100d0
               	movslq	%edi, %r11
               	leaq	0xfe4f(%rip), %r9       # 0x4100e0
               	movq	%r11, %r8
               	shlq	$0x2, %r8
               	movq	%r9, %rdi
               	addq	%r8, %rdi
               	movl	%r11d, (%rdi)
               	movq	%r11, %r8
               	shlq	$0x2, %r8
               	movq	%r9, %r11
               	addq	%r8, %r11
               	movslq	(%r11), %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	xorq	%rbx, %rbx
               	movq	%rbx, %rdi
               	callq	0x400287 <.text+0x17>
               	movq	%rax, %r9
               	movq	%fs:0x0, %r9
               	subq	$0x10, %r9
               	movslq	(%r9), %rbx
               	cmpq	$0x7, %rbx
               	je	0x400307 <.text+0x97>
               	movl	$0x1, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	%fs:0x0, %r9
               	subq	$0x8, %r9
               	movslq	(%r9), %rbx
               	cmpq	$-0x3, %rbx
               	je	0x40033f <.text+0xcf>
               	movl	$0x2, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	%fs:0x0, %r9
               	subq	$0x10, %r9
               	movq	%fs:0x0, %rbx
               	subq	$0x10, %rbx
               	movslq	(%rbx), %r8
               	movq	%fs:0x0, %rbx
               	subq	$0x8, %rbx
               	movslq	(%rbx), %rdi
               	movq	%r8, %rbx
               	addq	%rdi, %rbx
               	movslq	%ebx, %rbx
               	movl	%ebx, (%r9)
               	movq	%fs:0x0, %rdi
               	subq	$0x10, %rdi
               	movslq	(%rdi), %rbx
               	cmpq	$0x4, %rbx
               	je	0x4003b9 <.text+0x149>
               	movl	$0x3, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rdi, %rdi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	orb	(%r9), %cl
               	jbe	0x400407 <.text+0x197>
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
               	jae	0x40048e <.text+0x21e>
               	<unknown>
               	orb	(%rcx), %cl
               	jb	0x400485 <.text+0x215>
               	insl	%dx, %es:(%rdi)
               	outsl	(%rsi), %dx
               	je	0x400489 <.text+0x219>
               	andb	%ch, 0x74(%rax)
               	je	0x400499 <.text+0x229>
               	jae	0x400465 <.text+0x1f5>
               	<unknown>
               	<unknown>
               	imull	$0x6f632e62, 0x75(%eax,%ebp,2), %esi # imm = 0x6F632E62
               	insl	%dx, %es:(%rdi)
               	<unknown>
               	imull	$0x6d, 0x6f(%rdx), %esi
               	jns	0x4004a1 <.text+0x231>
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
               	callq	0x400517 <exit>
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
               	jbe	0x4004cb <.text+0x25b>
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
               	jae	0x400552 <exit+0x3b>
               	<unknown>
               	orb	(%rcx), %cl
               	jb	0x400549 <exit+0x32>
               	insl	%dx, %es:(%rdi)
               	outsl	(%rsi), %dx
               	je	0x40054d <exit+0x36>
               	andb	%ch, 0x74(%rax)
               	je	0x40055d <exit+0x46>
               	jae	0x400529 <exit+0x12>
               	<unknown>
               	<unknown>
               	imull	$0x6f632e62, 0x75(%eax,%ebp,2), %esi # imm = 0x6F632E62
               	insl	%dx, %es:(%rdi)
               	<unknown>
               	imull	$0x6d, 0x6f(%rdx), %esi
               	jns	0x400565 <exit+0x4e>
               	pushq	$0x6461622f             # imm = 0x6461622F
               	movslq	(%rsi), %ebp
               	imull	$0x0, (%eax,%eax), %esi
               	addb	%al, (%rax)
               	addb	%al, (%rax)
               	addb	%bh, %bh

<exit>:
               	jmpq	*0xfbb3(%rip)           # 0x4100d0
