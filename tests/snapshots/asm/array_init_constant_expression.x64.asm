
array_init_constant_expression.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400237 <.text+0x17>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	leaq	0xfe92(%rip), %r11      # 0x4100d0
               	movslq	(%r11), %r9
               	cmpq	$0x10, %r9
               	je	0x400254 <.text+0x34>
               	movl	$0xb, %eax
               	retq
               	leaq	0xfe75(%rip), %r11      # 0x4100d0
               	movq	%r11, %rax
               	addq	$0x4, %rax
               	movslq	(%rax), %r11
               	cmpq	$0x80, %r11
               	je	0x40027f <.text+0x5f>
               	movl	$0xc, %r11d
               	movq	%r11, %rax
               	retq
               	leaq	0xfe4a(%rip), %rax      # 0x4100d0
               	movq	%rax, %r11
               	addq	$0x8, %r11
               	movslq	(%r11), %rax
               	cmpq	$0x4, %rax
               	je	0x4002a6 <.text+0x86>
               	movl	$0xd, %eax
               	retq
               	leaq	0xfe33(%rip), %r11      # 0x4100e0
               	movslq	(%r11), %rax
               	cmpq	$0x90, %rax
               	je	0x4002c3 <.text+0xa3>
               	movl	$0xe, %eax
               	retq
               	leaq	0xfe16(%rip), %r11      # 0x4100e0
               	movq	%r11, %rax
               	addq	$0x4, %rax
               	movslq	(%rax), %r11
               	cmpq	$0x94, %r11
               	je	0x4002ee <.text+0xce>
               	movl	$0xf, %r11d
               	movq	%r11, %rax
               	retq
               	leaq	0xfdeb(%rip), %rax      # 0x4100e0
               	movq	%rax, %r11
               	addq	$0x8, %r11
               	movslq	(%r11), %rax
               	cmpq	$0x10, %rax
               	je	0x400315 <.text+0xf5>
               	movl	$0x10, %eax
               	retq
               	leaq	0xfdd4(%rip), %r11      # 0x4100f0
               	movslq	(%r11), %rax
               	cmpq	$0x100, %rax            # imm = 0x100
               	je	0x400332 <.text+0x112>
               	movl	$0x11, %eax
               	retq
               	leaq	0xfdb7(%rip), %r11      # 0x4100f0
               	movq	%r11, %rax
               	addq	$0x4, %rax
               	movslq	(%rax), %r11
               	cmpq	$0x40, %r11
               	je	0x40035d <.text+0x13d>
               	movl	$0x12, %r11d
               	movq	%r11, %rax
               	retq
               	leaq	0xfd94(%rip), %rax      # 0x4100f8
               	movslq	(%rax), %r11
               	cmpq	$0x11, %r11
               	je	0x40037e <.text+0x15e>
               	movl	$0x13, %r11d
               	movq	%r11, %rax
               	retq
               	leaq	0xfd73(%rip), %rax      # 0x4100f8
               	movq	%rax, %r11
               	addq	$0x4, %r11
               	movslq	(%r11), %rax
               	cmpq	$0x70, %rax
               	je	0x4003a5 <.text+0x185>
               	movl	$0x14, %eax
               	retq
               	leaq	0xfd4c(%rip), %r11      # 0x4100f8
               	movq	%r11, %rax
               	addq	$0x8, %rax
               	movslq	(%rax), %r11
               	cmpq	$0x30, %r11
               	je	0x4003d0 <.text+0x1b0>
               	movl	$0x15, %r11d
               	movq	%r11, %rax
               	retq
               	leaq	0xfd31(%rip), %rax      # 0x410108
               	movslq	(%rax), %r11
               	cmpq	$0x90, %r11
               	je	0x4003f1 <.text+0x1d1>
               	movl	$0x16, %r11d
               	movq	%r11, %rax
               	retq
               	leaq	0xfd10(%rip), %rax      # 0x410108
               	movq	%rax, %r11
               	addq	$0x4, %r11
               	movslq	(%r11), %rax
               	cmpq	$0x10, %rax
               	je	0x400418 <.text+0x1f8>
               	movl	$0x17, %eax
               	retq
               	leaq	0xfce9(%rip), %r11      # 0x410108
               	movq	%r11, %rax
               	addq	$0x8, %rax
               	movslq	(%rax), %r11
               	cmpq	$0x4, %r11
               	je	0x400443 <.text+0x223>
               	movl	$0x18, %r11d
               	movq	%r11, %rax
               	retq
               	leaq	0xfcbe(%rip), %rax      # 0x410108
               	movq	%rax, %r11
               	addq	$0xc, %r11
               	movslq	(%r11), %rax
               	cmpq	$0x14, %rax
               	je	0x40046a <.text+0x24a>
               	movl	$0x19, %eax
               	retq
               	xorq	%r11, %r11
               	movq	%r11, %rax
               	retq
               	addb	%al, (%rax)
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
               	jae	0x400532 <.text+0x312>
               	<unknown>
               	orb	(%rcx), %cl
               	jb	0x400529 <.text+0x309>
               	insl	%dx, %es:(%rdi)
               	outsl	(%rsi), %dx
               	je	0x40052d <.text+0x30d>
               	andb	%ch, 0x74(%rax)
               	je	0x40053d <.text+0x31d>
               	jae	0x400509 <.text+0x2e9>
               	<unknown>
               	<unknown>
               	imull	$0x6f632e62, 0x75(%eax,%ebp,2), %esi # imm = 0x6F632E62
               	insl	%dx, %es:(%rdi)
               	<unknown>
               	imull	$0x6d, 0x6f(%rdx), %esi
               	jns	0x400545 <.text+0x325>
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
               	callq	0x4005b7 <exit>
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
               	jbe	0x40056b <.text+0x34b>
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
               	jae	0x4005f2 <exit+0x3b>
               	<unknown>
               	orb	(%rcx), %cl
               	jb	0x4005e9 <exit+0x32>
               	insl	%dx, %es:(%rdi)
               	outsl	(%rsi), %dx
               	je	0x4005ed <exit+0x36>
               	andb	%ch, 0x74(%rax)
               	je	0x4005fd <exit+0x46>
               	jae	0x4005c9 <exit+0x12>
               	<unknown>
               	<unknown>
               	imull	$0x6f632e62, 0x75(%eax,%ebp,2), %esi # imm = 0x6F632E62
               	insl	%dx, %es:(%rdi)
               	<unknown>
               	imull	$0x6d, 0x6f(%rdx), %esi
               	jns	0x400605 <exit+0x4e>
               	pushq	$0x6461622f             # imm = 0x6461622F
               	movslq	(%rsi), %ebp
               	imull	$0x0, (%eax,%eax), %esi
               	addb	%al, (%rax)
               	addb	%al, (%rax)
               	addb	%bh, %bh

<exit>:
               	jmpq	*0xfb03(%rip)           # 0x4100c0
