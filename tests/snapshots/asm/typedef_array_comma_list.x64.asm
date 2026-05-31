
typedef_array_comma_list.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400237 <.text+0x17>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x210, %rsp            # imm = 0x210
               	leaq	0xfe87(%rip), %r11      # 0x4100d0
               	movq	(%r11), %r9
               	cmpq	$0x0, %r9
               	je	0x400267 <.text+0x47>
               	movl	$0x1, %eax
               	addq	$0x210, %rsp            # imm = 0x210
               	popq	%rbp
               	retq
               	leaq	0xfe62(%rip), %r11      # 0x4100d0
               	movq	%r11, %rax
               	addq	$0x78, %rax
               	movq	(%rax), %r11
               	cmpq	$0x0, %r11
               	je	0x40029a <.text+0x7a>
               	movl	$0x2, %r11d
               	movq	%r11, %rax
               	addq	$0x210, %rsp            # imm = 0x210
               	popq	%rbp
               	retq
               	leaq	0xfeaf(%rip), %rax      # 0x410150
               	movq	(%rax), %r11
               	cmpq	$0x1, %r11
               	je	0x4002c3 <.text+0xa3>
               	movl	$0x3, %r11d
               	movq	%r11, %rax
               	addq	$0x210, %rsp            # imm = 0x210
               	popq	%rbp
               	retq
               	leaq	0xfe86(%rip), %rax      # 0x410150
               	movq	%rax, %r11
               	addq	$0x8, %r11
               	movq	(%r11), %rax
               	cmpq	$0x0, %rax
               	je	0x4002f2 <.text+0xd2>
               	movl	$0x4, %eax
               	addq	$0x210, %rsp            # imm = 0x210
               	popq	%rbp
               	retq
               	leaq	0xfe57(%rip), %r11      # 0x410150
               	movq	%r11, %rax
               	addq	$0x78, %rax
               	movq	(%rax), %r11
               	cmpq	$0x0, %r11
               	je	0x400325 <.text+0x105>
               	movl	$0x5, %r11d
               	movq	%r11, %rax
               	addq	$0x210, %rsp            # imm = 0x210
               	popq	%rbp
               	retq
               	leaq	0xfea4(%rip), %rax      # 0x4101d0
               	movq	(%rax), %r11
               	cmpq	$0x0, %r11
               	je	0x40034e <.text+0x12e>
               	movl	$0x6, %r11d
               	movq	%r11, %rax
               	addq	$0x210, %rsp            # imm = 0x210
               	popq	%rbp
               	retq
               	leaq	0xfe7b(%rip), %rax      # 0x4101d0
               	movq	%rax, %r11
               	addq	$0x10, %r11
               	movq	(%r11), %rax
               	cmpq	$0x7, %rax
               	je	0x40037d <.text+0x15d>
               	movl	$0x7, %eax
               	addq	$0x210, %rsp            # imm = 0x210
               	popq	%rbp
               	retq
               	leaq	0xfe4c(%rip), %r11      # 0x4101d0
               	movq	%r11, %rax
               	addq	$0x78, %rax
               	movq	(%rax), %r11
               	cmpq	$0x0, %r11
               	je	0x4003b0 <.text+0x190>
               	movl	$0x8, %r11d
               	movq	%r11, %rax
               	addq	$0x210, %rsp            # imm = 0x210
               	popq	%rbp
               	retq
               	movl	$0x40, %eax
               	movslq	%eax, %rax
               	movq	%rax, %r11
               	shlq	$0x3, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x200, %r11            # imm = 0x200
               	je	0x4003e1 <.text+0x1c1>
               	movl	$0x9, %r11d
               	movq	%r11, %rax
               	addq	$0x210, %rsp            # imm = 0x210
               	popq	%rbp
               	retq
               	movl	$0x40, %eax
               	movslq	%eax, %rax
               	movq	%rax, %r11
               	shlq	$0x3, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x200, %r11            # imm = 0x200
               	je	0x400412 <.text+0x1f2>
               	movl	$0xa, %r11d
               	movq	%r11, %rax
               	addq	$0x210, %rsp            # imm = 0x210
               	popq	%rbp
               	retq
               	leaq	0xfe37(%rip), %rax      # 0x410250
               	movq	%rax, %r11
               	addq	$0x138, %r11            # imm = 0x138
               	movl	$0x2a, %eax
               	movq	%rax, (%r11)
               	leaq	0x1001e(%rip), %r8      # 0x410450
               	movq	%r8, %rax
               	addq	$0x1f8, %rax            # imm = 0x1F8
               	movabsq	$-0x1, %r8
               	movq	%r8, (%rax)
               	movq	(%r11), %rdi
               	cmpq	$0x2a, %rdi
               	je	0x400467 <.text+0x247>
               	movl	$0xb, %eax
               	addq	$0x210, %rsp            # imm = 0x210
               	popq	%rbp
               	retq
               	leaq	0xffe2(%rip), %r11      # 0x410450
               	movq	%r11, %rax
               	addq	$0x1f8, %rax            # imm = 0x1F8
               	movq	(%rax), %r11
               	cmpq	$-0x1, %r11
               	je	0x40049a <.text+0x27a>
               	movl	$0xc, %r11d
               	movq	%r11, %rax
               	addq	$0x210, %rsp            # imm = 0x210
               	popq	%rbp
               	retq
               	leaq	0xfdaf(%rip), %rax      # 0x410250
               	movq	(%rax), %r11
               	cmpq	$0x0, %r11
               	je	0x4004c3 <.text+0x2a3>
               	movl	$0xd, %r11d
               	movq	%r11, %rax
               	addq	$0x210, %rsp            # imm = 0x210
               	popq	%rbp
               	retq
               	leaq	0xff86(%rip), %rax      # 0x410450
               	movq	(%rax), %r11
               	cmpq	$0x0, %r11
               	je	0x4004ec <.text+0x2cc>
               	movl	$0xe, %r11d
               	movq	%r11, %rax
               	addq	$0x210, %rsp            # imm = 0x210
               	popq	%rbp
               	retq
               	leaq	-0x208(%rbp), %rax
               	movq	%rax, %r11
               	addq	$0x200, %r11            # imm = 0x200
               	movl	$0x63, %eax
               	movl	%eax, (%r11)
               	leaq	-0x208(%rbp), %r8
               	movq	%r8, %rax
               	addq	$0x200, %rax            # imm = 0x200
               	movslq	(%rax), %r8
               	cmpq	$0x63, %r8
               	je	0x400538 <.text+0x318>
               	movl	$0xf, %r8d
               	movq	%r8, %rax
               	addq	$0x210, %rsp            # imm = 0x210
               	popq	%rbp
               	retq
               	movl	$0x40, %eax
               	movq	%rax, %r8
               	shlq	$0x3, %r8
               	movslq	%r8d, %r8
               	movq	%r8, %rax
               	addq	$0x4, %rax
               	movslq	%eax, %rax
               	cmpq	$0x208, %rax            # imm = 0x208
               	jle	0x40056f <.text+0x34f>
               	movl	$0x10, %eax
               	addq	$0x210, %rsp            # imm = 0x210
               	popq	%rbp
               	retq
               	xorq	%r8, %r8
               	movq	%r8, %rax
               	addq	$0x210, %rsp            # imm = 0x210
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
               	orb	(%r9), %cl
               	jbe	0x4005b7 <.text+0x397>
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
               	jae	0x40063e <.text+0x41e>
               	<unknown>
               	orb	(%rcx), %cl
               	jb	0x400635 <.text+0x415>
               	insl	%dx, %es:(%rdi)
               	outsl	(%rsi), %dx
               	je	0x400639 <.text+0x419>
               	andb	%ch, 0x74(%rax)
               	je	0x400649 <.text+0x429>
               	jae	0x400615 <.text+0x3f5>
               	<unknown>
               	<unknown>
               	imull	$0x6f632e62, 0x75(%eax,%ebp,2), %esi # imm = 0x6F632E62
               	insl	%dx, %es:(%rdi)
               	<unknown>
               	imull	$0x6d, 0x6f(%rdx), %esi
               	jns	0x400651 <.text+0x431>
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
               	callq	0x4006c7 <exit>
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
               	jbe	0x40067b <.text+0x45b>
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
               	jae	0x400702 <exit+0x3b>
               	<unknown>
               	orb	(%rcx), %cl
               	jb	0x4006f9 <exit+0x32>
               	insl	%dx, %es:(%rdi)
               	outsl	(%rsi), %dx
               	je	0x4006fd <exit+0x36>
               	andb	%ch, 0x74(%rax)
               	je	0x40070d <exit+0x46>
               	jae	0x4006d9 <exit+0x12>
               	<unknown>
               	<unknown>
               	imull	$0x6f632e62, 0x75(%eax,%ebp,2), %esi # imm = 0x6F632E62
               	insl	%dx, %es:(%rdi)
               	<unknown>
               	imull	$0x6d, 0x6f(%rdx), %esi
               	jns	0x400715 <exit+0x4e>
               	pushq	$0x6461622f             # imm = 0x6461622F
               	movslq	(%rsi), %ebp
               	imull	$0x0, (%eax,%eax), %esi
               	addb	%al, (%rax)
               	addb	%al, (%rax)
               	addb	%bh, %bh

<exit>:
               	jmpq	*0xf9f3(%rip)           # 0x4100c0
