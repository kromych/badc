
mem2reg_unsigned_narrow.x64:	file format elf64-x86-64

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
               	movl	$0x12345, %r9d          # imm = 0x12345
               	xorq	%r8, %r8
               	movl	%r8d, -0x18(%rbp)
               	movl	%r8d, -0x20(%rbp)
               	movl	%r8d, -0x28(%rbp)
               	jmp	0x400262 <.text+0x42>
               	movslq	-0x18(%rbp), %r8
               	cmpq	$0x3, %r8
               	jge	0x4002c2 <.text+0xa2>
               	movslq	-0x20(%rbp), %r8
               	movq	%r11, %rdi
               	andq	$0xff, %rdi
               	movq	%r8, %rsi
               	addq	%rdi, %rsi
               	movslq	%esi, %rsi
               	movl	%esi, -0x20(%rbp)
               	movslq	-0x28(%rbp), %rdi
               	movq	%r9, %rsi
               	andq	$0xffff, %rsi           # imm = 0xFFFF
               	movq	%rdi, %r8
               	addq	%rsi, %r8
               	movslq	%r8d, %r8
               	movl	%r8d, -0x28(%rbp)
               	movslq	-0x18(%rbp), %rsi
               	movq	%rsi, %r8
               	addq	$0x1, %r8
               	movslq	%r8d, %r8
               	movl	%r8d, -0x18(%rbp)
               	jmp	0x400262 <.text+0x42>
               	xorq	%r8, %r8
               	movl	%r8d, -0x30(%rbp)
               	movq	%r11, %rsi
               	andq	$0xff, %rsi
               	movq	%rsi, %r11
               	xorq	$0x2c, %r11
               	movl	$0xffffffff, %esi       # imm = 0xFFFFFFFF
               	andq	%r11, %rsi
               	cmpq	$0x0, %rsi
               	je	0x40030c <.text+0xec>
               	movslq	-0x30(%rbp), %rsi
               	movq	%rsi, %r11
               	addq	$0x1, %r11
               	movslq	%r11d, %r11
               	movl	%r11d, -0x30(%rbp)
               	jmp	0x40030c <.text+0xec>
               	movq	%r9, %r11
               	andq	$0xffff, %r11           # imm = 0xFFFF
               	movq	%r11, %rsi
               	xorq	$0x2345, %rsi           # imm = 0x2345
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%rsi, %r11
               	cmpq	$0x0, %r11
               	je	0x40034f <.text+0x12f>
               	movslq	-0x30(%rbp), %r11
               	movq	%r11, %rsi
               	addq	$0x2, %rsi
               	movslq	%esi, %rsi
               	movl	%esi, -0x30(%rbp)
               	jmp	0x40034f <.text+0x12f>
               	movslq	-0x20(%rbp), %rsi
               	movl	$0x84, %r11d
               	movslq	%r11d, %r11
               	cmpq	%r11, %rsi
               	je	0x40037f <.text+0x15f>
               	movslq	-0x30(%rbp), %r11
               	movq	%r11, %r9
               	addq	$0x4, %r9
               	movslq	%r9d, %r9
               	movl	%r9d, -0x30(%rbp)
               	jmp	0x40037f <.text+0x15f>
               	movslq	-0x28(%rbp), %r9
               	movl	$0x69cf, %r11d          # imm = 0x69CF
               	movslq	%r11d, %r11
               	cmpq	%r11, %r9
               	je	0x4003ae <.text+0x18e>
               	movslq	-0x30(%rbp), %r11
               	movq	%r11, %rsi
               	addq	$0x8, %rsi
               	movslq	%esi, %rsi
               	movl	%esi, -0x30(%rbp)
               	jmp	0x4003ae <.text+0x18e>
               	movslq	-0x30(%rbp), %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	orb	(%r9), %cl
               	jbe	0x4003f3 <.text+0x1d3>
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
               	jae	0x40047a <.text+0x25a>
               	<unknown>
               	orb	(%rcx), %cl
               	jb	0x400471 <.text+0x251>
               	insl	%dx, %es:(%rdi)
               	outsl	(%rsi), %dx
               	je	0x400475 <.text+0x255>
               	andb	%ch, 0x74(%rax)
               	je	0x400485 <.text+0x265>
               	jae	0x400451 <.text+0x231>
               	<unknown>
               	<unknown>
               	imull	$0x6f632e62, 0x75(%eax,%ebp,2), %esi # imm = 0x6F632E62
               	insl	%dx, %es:(%rdi)
               	<unknown>
               	imull	$0x6d, 0x6f(%rdx), %esi
               	jns	0x40048d <.text+0x26d>
               	pushq	$0x6461622f             # imm = 0x6461622F
               	movslq	(%rsi), %ebp
               	imull	$0x89485500, (%eax,%eax), %esi # imm = 0x89485500
               	inl	$0x48, %eax
               	subl	$0x10, %esp
               	movq	%rbx, (%rsp)
               	movslq	%edi, %rbx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	0x4004f7 <exit>
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
               	jbe	0x4004ab <.text+0x28b>
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
               	jae	0x400532 <exit+0x3b>
               	<unknown>
               	orb	(%rcx), %cl
               	jb	0x400529 <exit+0x32>
               	insl	%dx, %es:(%rdi)
               	outsl	(%rsi), %dx
               	je	0x40052d <exit+0x36>
               	andb	%ch, 0x74(%rax)
               	je	0x40053d <exit+0x46>
               	jae	0x400509 <exit+0x12>
               	<unknown>
               	<unknown>
               	imull	$0x6f632e62, 0x75(%eax,%ebp,2), %esi # imm = 0x6F632E62
               	insl	%dx, %es:(%rdi)
               	<unknown>
               	imull	$0x6d, 0x6f(%rdx), %esi
               	jns	0x400545 <exit+0x4e>
               	pushq	$0x6461622f             # imm = 0x6461622F
               	movslq	(%rsi), %ebp
               	imull	$0x0, (%eax,%eax), %esi
               	addb	%al, (%rax)
               	addb	%al, (%rax)
               	addb	%bh, %bh

<exit>:
               	jmpq	*0xfbc3(%rip)           # 0x4100c0
