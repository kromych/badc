
bitop_common_type.x64:	file format elf64-x86-64

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
               	movabsq	$0x14006f000, %r11      # imm = 0x14006F000
               	xorq	%r9, %r9
               	movq	%r11, %r8
               	orq	%r9, %r8
               	movq	%r8, %rdi
               	addq	$0x1, %rdi
               	movabsq	$0x14006f001, %r10      # imm = 0x14006F001
               	movq	%rdi, %r8
               	cmpq	%r10, %rdi
               	je	0x400283 <.text+0x63>
               	movl	$0x1, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	%r9, %r8
               	xorq	$-0x1, %r8
               	movq	%r11, %rax
               	andq	%r8, %rax
               	movq	%rax, %r8
               	addq	$0x1, %r8
               	movabsq	$0x14006f001, %r10      # imm = 0x14006F001
               	movq	%r8, %rax
               	cmpq	%r10, %r8
               	je	0x4002c5 <.text+0xa5>
               	movl	$0x2, %r8d
               	movq	%r8, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	%r11, %rax
               	xorq	%r9, %rax
               	movq	%rax, %r8
               	addq	$0x1, %r8
               	movabsq	$0x14006f001, %r10      # imm = 0x14006F001
               	movq	%r8, %rax
               	cmpq	%r10, %r8
               	je	0x4002fd <.text+0xdd>
               	movl	$0x3, %r8d
               	movq	%r8, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x14006f001, %rax      # imm = 0x14006F001
               	movq	%rax, %r8
               	subq	$0x1, %r8
               	movl	$0xf, %eax
               	movslq	%eax, %rax
               	movq	%r8, %rsi
               	orq	%rax, %rsi
               	movq	%rsi, %rax
               	addq	$0x1, %rax
               	movabsq	$0x14006f010, %r10      # imm = 0x14006F010
               	movq	%rax, %rsi
               	cmpq	%r10, %rax
               	je	0x40034d <.text+0x12d>
               	movl	$0x4, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	%r11, %rsi
               	orq	%r9, %rsi
               	movabsq	$0x14006f000, %r10      # imm = 0x14006F000
               	movq	%rsi, %rax
               	cmpq	%r10, %rsi
               	je	0x40037a <.text+0x15a>
               	movl	$0x5, %esi
               	movq	%rsi, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	%r11, %rax
               	orq	%r9, %rax
               	movabsq	$0x14006f000, %r10      # imm = 0x14006F000
               	movq	%rax, %rsi
               	cmpq	%r10, %rax
               	je	0x4003a4 <.text+0x184>
               	movl	$0x6, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	%r11, %rsi
               	orq	%r9, %rsi
               	movabsq	$0x100000000, %r11      # imm = 0x100000000
               	movq	%rsi, %r9
               	cmpq	%r11, %rsi
               	seta	%r9b
               	movzbq	%r9b, %r9
               	cmpq	$0x0, %r9
               	jne	0x4003dd <.text+0x1bd>
               	movl	$0x7, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rsi, %rsi
               	movq	%rsi, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
               	orb	(%r9), %cl
               	jbe	0x400427 <.text+0x207>
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
               	jae	0x4004ae <.text+0x28e>
               	<unknown>
               	orb	(%rcx), %cl
               	jb	0x4004a5 <.text+0x285>
               	insl	%dx, %es:(%rdi)
               	outsl	(%rsi), %dx
               	je	0x4004a9 <.text+0x289>
               	andb	%ch, 0x74(%rax)
               	je	0x4004b9 <.text+0x299>
               	jae	0x400485 <.text+0x265>
               	<unknown>
               	<unknown>
               	imull	$0x6f632e62, 0x75(%eax,%ebp,2), %esi # imm = 0x6F632E62
               	insl	%dx, %es:(%rdi)
               	<unknown>
               	imull	$0x6d, 0x6f(%rdx), %esi
               	jns	0x4004c1 <.text+0x2a1>
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
               	callq	0x400537 <exit>
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
               	jbe	0x4004eb <.text+0x2cb>
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
               	jae	0x400572 <exit+0x3b>
               	<unknown>
               	orb	(%rcx), %cl
               	jb	0x400569 <exit+0x32>
               	insl	%dx, %es:(%rdi)
               	outsl	(%rsi), %dx
               	je	0x40056d <exit+0x36>
               	andb	%ch, 0x74(%rax)
               	je	0x40057d <exit+0x46>
               	jae	0x400549 <exit+0x12>
               	<unknown>
               	<unknown>
               	imull	$0x6f632e62, 0x75(%eax,%ebp,2), %esi # imm = 0x6F632E62
               	insl	%dx, %es:(%rdi)
               	<unknown>
               	imull	$0x6d, 0x6f(%rdx), %esi
               	jns	0x400585 <exit+0x4e>
               	pushq	$0x6461622f             # imm = 0x6461622F
               	movslq	(%rsi), %ebp
               	imull	$0x0, (%eax,%eax), %esi
               	addb	%al, (%rax)
               	addb	%al, (%rax)
               	addb	%bh, %bh

<exit>:
               	jmpq	*0xfb83(%rip)           # 0x4100c0
