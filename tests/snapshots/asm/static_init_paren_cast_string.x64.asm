
static_init_paren_cast_string.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400237 <.text+0x17>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	leaq	0xfeea(%rip), %r11      # 0x410128
               	movq	(%r11), %r9
               	movzbq	(%r9), %r11
               	movq	%r11, %r9
               	xorq	$0x5, %r9
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r9, %r11
               	cmpq	$0x0, %r11
               	je	0x40026b <.text+0x4b>
               	movl	$0x1, %eax
               	retq
               	leaq	0xfeb6(%rip), %r9       # 0x410128
               	movq	(%r9), %rax
               	movq	%rax, %r9
               	addq	$0x5, %r9
               	movzbq	(%r9), %rax
               	movq	%rax, %r9
               	xorq	$0x1a, %r9
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%r9, %rax
               	cmpq	$0x0, %rax
               	je	0x4002a8 <.text+0x88>
               	movl	$0x2, %eax
               	retq
               	leaq	0xfe79(%rip), %r9       # 0x410128
               	movq	%r9, %rax
               	addq	$0x8, %rax
               	movq	(%rax), %r9
               	movzbq	(%r9), %rax
               	movq	%rax, %r9
               	xorq	$0x9, %r9
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%r9, %rax
               	cmpq	$0x0, %rax
               	je	0x4002e5 <.text+0xc5>
               	movl	$0x3, %eax
               	retq
               	leaq	0xfe3c(%rip), %r9       # 0x410128
               	movq	%r9, %rax
               	addq	$0x8, %rax
               	movq	(%rax), %r9
               	movq	%r9, %rax
               	addq	$0x9, %rax
               	movzbq	(%rax), %r9
               	movq	%r9, %rax
               	xorq	$0x4, %rax
               	movl	$0xffffffff, %r9d       # imm = 0xFFFFFFFF
               	andq	%rax, %r9
               	cmpq	$0x0, %r9
               	je	0x400331 <.text+0x111>
               	movl	$0x4, %r9d
               	movq	%r9, %rax
               	retq
               	leaq	0xfdf0(%rip), %rax      # 0x410128
               	movq	%rax, %r9
               	addq	$0x10, %r9
               	movq	(%r9), %rax
               	movq	%rax, %r9
               	addq	$0x9, %r9
               	movzbq	(%r9), %rax
               	movq	%rax, %r9
               	xorq	$0x1, %r9
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%r9, %rax
               	cmpq	$0x0, %rax
               	je	0x400378 <.text+0x158>
               	movl	$0x5, %eax
               	retq
               	xorq	%r9, %r9
               	movq	%r9, %rax
               	retq
               	orb	(%r9), %cl
               	jbe	0x4003b7 <.text+0x197>
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
               	jae	0x40043e <.text+0x21e>
               	<unknown>
               	orb	(%rcx), %cl
               	jb	0x400435 <.text+0x215>
               	insl	%dx, %es:(%rdi)
               	outsl	(%rsi), %dx
               	je	0x400439 <.text+0x219>
               	andb	%ch, 0x74(%rax)
               	je	0x400449 <.text+0x229>
               	jae	0x400415 <.text+0x1f5>
               	<unknown>
               	<unknown>
               	imull	$0x6f632e62, 0x75(%eax,%ebp,2), %esi # imm = 0x6F632E62
               	insl	%dx, %es:(%rdi)
               	<unknown>
               	imull	$0x6d, 0x6f(%rdx), %esi
               	jns	0x400451 <.text+0x231>
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
               	callq	0x4004c7 <exit>
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
               	jbe	0x40047b <.text+0x25b>
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
               	jae	0x400502 <exit+0x3b>
               	<unknown>
               	orb	(%rcx), %cl
               	jb	0x4004f9 <exit+0x32>
               	insl	%dx, %es:(%rdi)
               	outsl	(%rsi), %dx
               	je	0x4004fd <exit+0x36>
               	andb	%ch, 0x74(%rax)
               	je	0x40050d <exit+0x46>
               	jae	0x4004d9 <exit+0x12>
               	<unknown>
               	<unknown>
               	imull	$0x6f632e62, 0x75(%eax,%ebp,2), %esi # imm = 0x6F632E62
               	insl	%dx, %es:(%rdi)
               	<unknown>
               	imull	$0x6d, 0x6f(%rdx), %esi
               	jns	0x400515 <exit+0x4e>
               	pushq	$0x6461622f             # imm = 0x6461622F
               	movslq	(%rsi), %ebp
               	imull	$0x0, (%eax,%eax), %esi
               	addb	%al, (%rax)
               	addb	%al, (%rax)
               	addb	%bh, %bh

<exit>:
               	jmpq	*0xfbf3(%rip)           # 0x4100c0
