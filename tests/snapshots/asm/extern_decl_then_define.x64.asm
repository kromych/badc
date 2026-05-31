
extern_decl_then_define.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x40023f <.text+0x1f>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	leaq	0xfed2(%rip), %rax      # 0x410110
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	leaq	0xfe76(%rip), %r11      # 0x4100d0
               	leaq	0xfe8f(%rip), %r9       # 0x4100f0
               	cmpq	%r9, %r11
               	jne	0x400288 <.text+0x68>
               	movl	$0x1, %r9d
               	movq	%r9, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfe41(%rip), %r8       # 0x4100d0
               	movl	(%r8), %r9d
               	movl	$0xc1059ed8, %r11d      # imm = 0xC1059ED8
               	movq	%r9, %r8
               	cmpq	%r11, %r9
               	je	0x4002c2 <.text+0xa2>
               	movl	$0x2, %r9d
               	movq	%r9, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfe27(%rip), %r8       # 0x4100f0
               	movl	(%r8), %r9d
               	cmpq	$0x6a09e667, %r9        # imm = 0x6A09E667
               	je	0x4002f7 <.text+0xd7>
               	movl	$0x3, %r9d
               	movq	%r9, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfdd2(%rip), %r8       # 0x4100d0
               	movq	%r8, %r9
               	addq	$0x1c, %r9
               	movl	(%r9), %r8d
               	movl	$0xbefa4fa4, %r11d      # imm = 0xBEFA4FA4
               	movq	%r8, %r9
               	cmpq	%r11, %r8
               	je	0x40033b <.text+0x11b>
               	movl	$0x4, %r8d
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfdae(%rip), %r9       # 0x4100f0
               	movq	%r9, %r8
               	addq	$0x1c, %r8
               	movl	(%r8), %r9d
               	cmpq	$0x5be0cd19, %r9        # imm = 0x5BE0CD19
               	je	0x400379 <.text+0x159>
               	movl	$0x5, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	callq	0x400237 <.text+0x17>
               	movq	%rax, %r8
               	leaq	0xfd88(%rip), %rbx      # 0x410110
               	cmpq	%rbx, %r8
               	je	0x4003af <.text+0x18f>
               	movl	$0x6, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	callq	0x400237 <.text+0x17>
               	movq	%rax, %r11
               	movl	(%r11), %r12d
               	movl	$0xa5a5a5a5, %r10d      # imm = 0xA5A5A5A5
               	movq	%r12, %r11
               	cmpq	%r10, %r12
               	je	0x4003e9 <.text+0x1c9>
               	movl	$0x7, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	callq	0x400237 <.text+0x17>
               	movq	%rax, %r11
               	movq	%r11, %rbx
               	addq	$0x8, %rbx
               	movq	(%rbx), %r11
               	movl	$0xdeadbeef, %r10d      # imm = 0xDEADBEEF
               	movq	%r11, %rbx
               	cmpq	%r10, %r11
               	je	0x40042e <.text+0x20e>
               	movl	$0x8, %r11d
               	movq	%r11, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rbx, %rbx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	orb	(%r9), %cl
               	jbe	0x400483 <.text+0x263>
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
               	jae	0x40050a <.text+0x2ea>
               	<unknown>
               	orb	(%rcx), %cl
               	jb	0x400501 <.text+0x2e1>
               	insl	%dx, %es:(%rdi)
               	outsl	(%rsi), %dx
               	je	0x400505 <.text+0x2e5>
               	andb	%ch, 0x74(%rax)
               	je	0x400515 <.text+0x2f5>
               	jae	0x4004e1 <.text+0x2c1>
               	<unknown>
               	<unknown>
               	imull	$0x6f632e62, 0x75(%eax,%ebp,2), %esi # imm = 0x6F632E62
               	insl	%dx, %es:(%rdi)
               	<unknown>
               	imull	$0x6d, 0x6f(%rdx), %esi
               	jns	0x40051d <.text+0x2fd>
               	pushq	$0x6461622f             # imm = 0x6461622F
               	movslq	(%rsi), %ebp
               	imull	$0x89485500, (%eax,%eax), %esi # imm = 0x89485500
               	inl	$0x48, %eax
               	subl	$0x10, %esp
               	movq	%rbx, (%rsp)
               	movslq	%edi, %rbx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	0x400587 <exit>
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
               	jbe	0x40053b <.text+0x31b>
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
               	jae	0x4005c2 <exit+0x3b>
               	<unknown>
               	orb	(%rcx), %cl
               	jb	0x4005b9 <exit+0x32>
               	insl	%dx, %es:(%rdi)
               	outsl	(%rsi), %dx
               	je	0x4005bd <exit+0x36>
               	andb	%ch, 0x74(%rax)
               	je	0x4005cd <exit+0x46>
               	jae	0x400599 <exit+0x12>
               	<unknown>
               	<unknown>
               	imull	$0x6f632e62, 0x75(%eax,%ebp,2), %esi # imm = 0x6F632E62
               	insl	%dx, %es:(%rdi)
               	<unknown>
               	imull	$0x6d, 0x6f(%rdx), %esi
               	jns	0x4005d5 <exit+0x4e>
               	pushq	$0x6461622f             # imm = 0x6461622F
               	movslq	(%rsi), %ebp
               	imull	$0x0, (%eax,%eax), %esi
               	addb	%al, (%rax)
               	addb	%al, (%rax)
               	addb	%bh, %bh

<exit>:
               	jmpq	*0xfb33(%rip)           # 0x4100c0
