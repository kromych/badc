
typedef_array_outer_dim.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400342 <.text+0x122>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rdi, %r11
               	xorq	%r9, %r9
               	movq	%r9, -0x18(%rbp)
               	movl	%r9d, -0x8(%rbp)
               	jmp	0x400255 <.text+0x35>
               	movslq	-0x8(%rbp), %r9
               	cmpq	$0x4, %r9
               	jge	0x40028f <.text+0x6f>
               	jmp	0x400284 <.text+0x64>
               	leaq	-0x8(%rbp), %r9
               	movslq	(%r9), %r8
               	movq	%r8, %rdi
               	addq	$0x1, %rdi
               	movl	%edi, (%r9)
               	jmp	0x400255 <.text+0x35>
               	xorq	%rdi, %rdi
               	movl	%edi, -0x10(%rbp)
               	jmp	0x40029c <.text+0x7c>
               	movq	-0x18(%rbp), %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movslq	-0x10(%rbp), %rdi
               	cmpq	$0x10, %rdi
               	jge	0x40033d <.text+0x11d>
               	jmp	0x4002cb <.text+0xab>
               	leaq	-0x10(%rbp), %rdi
               	movslq	(%rdi), %r8
               	movq	%r8, %r9
               	addq	$0x1, %r9
               	movl	%r9d, (%rdi)
               	jmp	0x40029c <.text+0x7c>
               	movslq	-0x8(%rbp), %r9
               	movq	%r9, %r8
               	shlq	$0x7, %r8
               	movq	%r11, %rdi
               	addq	%r8, %rdi
               	movslq	-0x10(%rbp), %r8
               	movq	%r8, %rsi
               	shlq	$0x3, %rsi
               	movq	%rdi, %rdx
               	addq	%rsi, %rdx
               	movq	%r9, %rsi
               	shlq	$0x4, %rsi
               	movslq	%esi, %rsi
               	movq	%rsi, %r9
               	addq	%r8, %r9
               	movslq	%r9d, %r9
               	movq	%r9, (%rdx)
               	leaq	-0x18(%rbp), %rsi
               	movq	(%rsi), %r9
               	movslq	-0x8(%rbp), %rdx
               	movq	%rdx, %r8
               	shlq	$0x7, %r8
               	movq	%r11, %rdx
               	addq	%r8, %rdx
               	movslq	-0x10(%rbp), %r8
               	movq	%r8, %rdi
               	shlq	$0x3, %rdi
               	movq	%rdx, %r8
               	addq	%rdi, %r8
               	movq	(%r8), %rdi
               	movq	%r9, %r8
               	addq	%rdi, %r8
               	movq	%r8, (%rsi)
               	jmp	0x4002b2 <.text+0x92>
               	jmp	0x40026b <.text+0x4b>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x230, %rsp            # imm = 0x230
               	movq	%rbx, (%rsp)
               	movl	$0x40, %r11d
               	movslq	%r11d, %r11
               	movq	%r11, %r9
               	shlq	$0x3, %r9
               	movslq	%r9d, %r9
               	cmpq	$0x200, %r9             # imm = 0x200
               	je	0x40038a <.text+0x16a>
               	movl	$0x1, %r9d
               	movq	%r9, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x230, %rsp            # imm = 0x230
               	popq	%rbp
               	retq
               	xorq	%r11, %r11
               	movq	%r11, -0x208(%rbp)
               	movl	%r11d, -0x210(%rbp)
               	jmp	0x4003a0 <.text+0x180>
               	movslq	-0x210(%rbp), %r11
               	movl	$0x40, %r9d
               	movslq	%r9d, %r9
               	cmpq	%r9, %r11
               	jge	0x4003f9 <.text+0x1d9>
               	jmp	0x4003da <.text+0x1ba>
               	leaq	-0x210(%rbp), %r9
               	movslq	(%r9), %r8
               	movq	%r8, %r11
               	addq	$0x1, %r11
               	movl	%r11d, (%r9)
               	jmp	0x4003a0 <.text+0x180>
               	leaq	-0x208(%rbp), %r11
               	movq	(%r11), %r8
               	movslq	-0x210(%rbp), %r9
               	movq	%r8, %rdi
               	addq	%r9, %rdi
               	movq	%rdi, (%r11)
               	jmp	0x4003be <.text+0x19e>
               	leaq	-0x200(%rbp), %rbx
               	movq	%rbx, %rdi
               	callq	0x400237 <.text+0x17>
               	movq	%rax, %r9
               	movq	-0x208(%rbp), %rbx
               	cmpq	%rbx, %r9
               	je	0x400433 <.text+0x213>
               	movl	$0x2, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x230, %rsp            # imm = 0x230
               	popq	%rbp
               	retq
               	leaq	-0x200(%rbp), %r11
               	movq	(%r11), %rbx
               	cmpq	$0x0, %rbx
               	je	0x400462 <.text+0x242>
               	movl	$0x3, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x230, %rsp            # imm = 0x230
               	popq	%rbp
               	retq
               	leaq	-0x200(%rbp), %r11
               	movq	%r11, %rbx
               	addq	$0x1f8, %rbx            # imm = 0x1F8
               	movq	(%rbx), %r11
               	cmpq	$0x3f, %r11
               	je	0x40049c <.text+0x27c>
               	movl	$0x4, %r11d
               	movq	%r11, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x230, %rsp            # imm = 0x230
               	popq	%rbp
               	retq
               	leaq	-0x200(%rbp), %rbx
               	movq	%rbx, %r11
               	addq	$0xb8, %r11
               	movq	(%r11), %rbx
               	cmpq	$0x17, %rbx
               	je	0x4004d5 <.text+0x2b5>
               	movl	$0x5, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x230, %rsp            # imm = 0x230
               	popq	%rbp
               	retq
               	xorq	%r11, %r11
               	movq	%r11, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x230, %rsp            # imm = 0x230
               	popq	%rbp
               	retq
               	orb	(%r9), %cl
               	jbe	0x400523 <.text+0x303>
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
               	jae	0x4005aa <.text+0x38a>
               	<unknown>
               	orb	(%rcx), %cl
               	jb	0x4005a1 <.text+0x381>
               	insl	%dx, %es:(%rdi)
               	outsl	(%rsi), %dx
               	je	0x4005a5 <.text+0x385>
               	andb	%ch, 0x74(%rax)
               	je	0x4005b5 <.text+0x395>
               	jae	0x400581 <.text+0x361>
               	<unknown>
               	<unknown>
               	imull	$0x6f632e62, 0x75(%eax,%ebp,2), %esi # imm = 0x6F632E62
               	insl	%dx, %es:(%rdi)
               	<unknown>
               	imull	$0x6d, 0x6f(%rdx), %esi
               	jns	0x4005bd <.text+0x39d>
               	pushq	$0x6461622f             # imm = 0x6461622F
               	movslq	(%rsi), %ebp
               	imull	$0x89485500, (%eax,%eax), %esi # imm = 0x89485500
               	inl	$0x48, %eax
               	subl	$0x10, %esp
               	movq	%rbx, (%rsp)
               	movslq	%edi, %rbx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	0x400627 <exit>
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
               	jbe	0x4005db <.text+0x3bb>
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
               	jae	0x400662 <exit+0x3b>
               	<unknown>
               	orb	(%rcx), %cl
               	jb	0x400659 <exit+0x32>
               	insl	%dx, %es:(%rdi)
               	outsl	(%rsi), %dx
               	je	0x40065d <exit+0x36>
               	andb	%ch, 0x74(%rax)
               	je	0x40066d <exit+0x46>
               	jae	0x400639 <exit+0x12>
               	<unknown>
               	<unknown>
               	imull	$0x6f632e62, 0x75(%eax,%ebp,2), %esi # imm = 0x6F632E62
               	insl	%dx, %es:(%rdi)
               	<unknown>
               	imull	$0x6d, 0x6f(%rdx), %esi
               	jns	0x400675 <exit+0x4e>
               	pushq	$0x6461622f             # imm = 0x6461622F
               	movslq	(%rsi), %ebp
               	imull	$0x0, (%eax,%eax), %esi
               	addb	%al, (%rax)
               	addb	%al, (%rax)
               	addb	%bh, %bh

<exit>:
               	jmpq	*0xfa93(%rip)           # 0x4100c0
