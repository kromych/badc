
typedef_array_param_decay.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400334 <.text+0x114>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, %r11
               	movq	%rsi, %r9
               	xorq	%r8, %r8
               	movl	%r8d, -0x8(%rbp)
               	jmp	0x400254 <.text+0x34>
               	movslq	-0x8(%rbp), %r8
               	cmpq	$0x10, %r8
               	jge	0x4002a5 <.text+0x85>
               	jmp	0x400283 <.text+0x63>
               	leaq	-0x8(%rbp), %r8
               	movslq	(%r8), %rdi
               	movq	%rdi, %rsi
               	addq	$0x1, %rsi
               	movl	%esi, (%r8)
               	jmp	0x400254 <.text+0x34>
               	movslq	-0x8(%rbp), %rsi
               	movq	%rsi, %rdi
               	shlq	$0x3, %rdi
               	movq	%r11, %rsi
               	addq	%rdi, %rsi
               	movq	%r9, %r8
               	addq	%rdi, %r8
               	movq	(%r8), %rdi
               	movq	%rdi, (%rsi)
               	jmp	0x40026a <.text+0x4a>
               	xorq	%rax, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, %r11
               	xorq	%r9, %r9
               	movq	%r9, -0x10(%rbp)
               	movl	%r9d, -0x8(%rbp)
               	jmp	0x4002cf <.text+0xaf>
               	movslq	-0x8(%rbp), %r9
               	cmpq	$0x10, %r9
               	jge	0x400327 <.text+0x107>
               	jmp	0x4002fe <.text+0xde>
               	leaq	-0x8(%rbp), %r9
               	movslq	(%r9), %r8
               	movq	%r8, %rdi
               	addq	$0x1, %rdi
               	movl	%edi, (%r9)
               	jmp	0x4002cf <.text+0xaf>
               	leaq	-0x10(%rbp), %rdi
               	movq	(%rdi), %r8
               	movslq	-0x8(%rbp), %r9
               	movq	%r9, %rsi
               	shlq	$0x3, %rsi
               	movq	%r11, %r9
               	addq	%rsi, %r9
               	movq	(%r9), %rsi
               	movq	%r8, %r9
               	addq	%rsi, %r9
               	movq	%r9, (%rdi)
               	jmp	0x4002e5 <.text+0xc5>
               	movq	-0x10(%rbp), %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x140, %rsp            # imm = 0x140
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	xorq	%r11, %r11
               	movl	%r11d, -0x108(%rbp)
               	jmp	0x40035c <.text+0x13c>
               	movslq	-0x108(%rbp), %r11
               	cmpq	$0x10, %r11
               	jge	0x4003bb <.text+0x19b>
               	jmp	0x400391 <.text+0x171>
               	leaq	-0x108(%rbp), %r11
               	movslq	(%r11), %r9
               	movq	%r9, %r8
               	addq	$0x1, %r8
               	movl	%r8d, (%r11)
               	jmp	0x40035c <.text+0x13c>
               	leaq	-0x80(%rbp), %r8
               	movslq	-0x108(%rbp), %r9
               	movq	%r9, %r11
               	shlq	$0x3, %r11
               	movq	%r8, %rdi
               	addq	%r11, %rdi
               	movq	%r9, %r11
               	addq	$0x1, %r11
               	movq	%r11, (%rdi)
               	jmp	0x400375 <.text+0x155>
               	leaq	-0x100(%rbp), %rbx
               	leaq	-0x80(%rbp), %r12
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	0x400237 <.text+0x17>
               	movq	%rax, %rdi
               	leaq	-0x100(%rbp), %r14
               	movq	%r14, %rdi
               	callq	0x4002b1 <.text+0x91>
               	movq	%rax, %r12
               	movl	$0x110, %r14d           # imm = 0x110
               	movslq	%r14d, %r14
               	movl	$0x2, %ebx
               	movq	%rbx, %r11
               	pushq	%rax
               	pushq	%rdx
               	movq	%r14, %rax
               	cqto
               	idivq	%r11
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	cmpq	%r8, %r12
               	je	0x400432 <.text+0x212>
               	movl	$0x1, %r8d
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x140, %rsp            # imm = 0x140
               	popq	%rbp
               	retq
               	leaq	-0x100(%rbp), %rbx
               	movq	(%rbx), %r8
               	cmpq	$0x1, %r8
               	je	0x40046c <.text+0x24c>
               	movl	$0x2, %r8d
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x140, %rsp            # imm = 0x140
               	popq	%rbp
               	retq
               	leaq	-0x100(%rbp), %rbx
               	movq	%rbx, %r8
               	addq	$0x78, %r8
               	movq	(%r8), %rbx
               	cmpq	$0x10, %rbx
               	je	0x4004af <.text+0x28f>
               	movl	$0x3, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x140, %rsp            # imm = 0x140
               	popq	%rbp
               	retq
               	xorq	%r8, %r8
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x140, %rsp            # imm = 0x140
               	popq	%rbp
               	retq
               	orb	(%r9), %cl
               	jbe	0x400507 <.text+0x2e7>
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
               	jae	0x40058e <.text+0x36e>
               	<unknown>
               	orb	(%rcx), %cl
               	jb	0x400585 <.text+0x365>
               	insl	%dx, %es:(%rdi)
               	outsl	(%rsi), %dx
               	je	0x400589 <.text+0x369>
               	andb	%ch, 0x74(%rax)
               	je	0x400599 <.text+0x379>
               	jae	0x400565 <.text+0x345>
               	<unknown>
               	<unknown>
               	imull	$0x6f632e62, 0x75(%eax,%ebp,2), %esi # imm = 0x6F632E62
               	insl	%dx, %es:(%rdi)
               	<unknown>
               	imull	$0x6d, 0x6f(%rdx), %esi
               	jns	0x4005a1 <.text+0x381>
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
               	callq	0x400617 <exit>
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
               	jbe	0x4005cb <.text+0x3ab>
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
               	jae	0x400652 <exit+0x3b>
               	<unknown>
               	orb	(%rcx), %cl
               	jb	0x400649 <exit+0x32>
               	insl	%dx, %es:(%rdi)
               	outsl	(%rsi), %dx
               	je	0x40064d <exit+0x36>
               	andb	%ch, 0x74(%rax)
               	je	0x40065d <exit+0x46>
               	jae	0x400629 <exit+0x12>
               	<unknown>
               	<unknown>
               	imull	$0x6f632e62, 0x75(%eax,%ebp,2), %esi # imm = 0x6F632E62
               	insl	%dx, %es:(%rdi)
               	<unknown>
               	imull	$0x6d, 0x6f(%rdx), %esi
               	jns	0x400665 <exit+0x4e>
               	pushq	$0x6461622f             # imm = 0x6461622F
               	movslq	(%rsi), %ebp
               	imull	$0x0, (%eax,%eax), %esi
               	addb	%al, (%rax)
               	addb	%al, (%rax)
               	addb	%bh, %bh

<exit>:
               	jmpq	*0xfaa3(%rip)           # 0x4100c0
