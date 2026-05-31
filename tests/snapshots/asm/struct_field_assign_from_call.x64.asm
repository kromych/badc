
struct_field_assign_from_call.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x40070f <.text+0x44f>
               	movq	%rax, %rdi
               	callq	*0xfe19(%rip)           # 0x4100f0
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movslq	%edi, %rbx
               	leaq	0xfe06(%rip), %r9       # 0x410100
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	movq	%r9, %rdi
               	addq	%r8, %rdi
               	movq	(%rdi), %r8
               	cmpq	$0x0, %r8
               	je	0x40034b <.text+0x8b>
               	leaq	0xfde2(%rip), %rdi      # 0x410100
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	movq	%rdi, %r9
               	addq	%r8, %r9
               	movq	(%r9), %r8
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r9
               	xorq	%r12, %r12
               	leaq	0xfdbf(%rip), %rdi      # 0x410118
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	movq	%rsi, %rdi
               	addq	$0x8, %rdi
               	leaq	0xfdad(%rip), %rsi      # 0x41011e
               	movq	%rsi, (%rdi)
               	leaq	-0x18(%rbp), %r9
               	movq	%r9, %rsi
               	addq	$0x10, %rsi
               	leaq	0xfd9c(%rip), %r9       # 0x410125
               	movq	%r9, (%rsi)
               	leaq	-0x18(%rbp), %rdi
               	movq	%rbx, %r9
               	shlq	$0x3, %r9
               	movq	%rdi, %rsi
               	addq	%r9, %rsi
               	movq	(%rsi), %r14
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	xorl	%eax, %eax
               	callq	0x400977 <dlsym>
               	movq	%rax, %rsi
               	cmpq	$0x0, %rsi
               	je	0x4003dc <.text+0x11c>
               	leaq	0xfd3c(%rip), %r14      # 0x410100
               	movq	%rbx, %r12
               	shlq	$0x3, %r12
               	movq	%r14, %rdi
               	addq	%r12, %rdi
               	movq	(%rsi), %r12
               	movq	%r12, (%rdi)
               	jmp	0x4003dc <.text+0x11c>
               	leaq	0xfd1d(%rip), %r12      # 0x410100
               	movq	%rbx, %rsi
               	shlq	$0x3, %rsi
               	movq	%r12, %rbx
               	addq	%rsi, %rbx
               	movq	(%rbx), %rsi
               	movq	%rsi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movslq	%edx, %rdx
               	movslq	%ecx, %rcx
               	movslq	%r8d, %r8
               	movl	$0x4, %r11d
               	movl	%r11d, (%rsi)
               	movl	$0x1234abcd, %eax       # imm = 0x1234ABCD
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xa0, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movq	%rdi, %r10
               	movq	%r10, 0x58(%rsp)
               	movq	%rsi, %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x58(%rsp), %r10
               	addq	$0x8, %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x38(%rsp), %r10
               	movq	(%r10), %r10
               	movq	%r10, 0x48(%rsp)
               	movq	0x58(%rsp), %rsi
               	addq	$0x18, %rsi
               	movq	(%rsi), %r10
               	movq	%r10, 0x50(%rsp)
               	movq	0x38(%rsp), %r10
               	movq	(%r10), %rbx
               	movq	0x58(%rsp), %r15
               	addq	$0x14, %r15
               	movq	0x58(%rsp), %rsi
               	addq	$0x10, %rsi
               	movslq	(%rsi), %rdx
               	movq	%rdx, %rsi
               	addq	$0x1, %rsi
               	movslq	%esi, %r12
               	movl	$0x10, %r10d
               	movq	%r10, 0x30(%rsp)
               	movl	$0x7fff, %r14d          # imm = 0x7FFF
               	movq	%rbx, %rdi
               	movq	%r14, %r8
               	movq	%r12, %rdx
               	movq	%r15, %rsi
               	movq	0x30(%rsp), %rcx
               	movq	0x40(%rsp), %r9
               	callq	0x400410 <.text+0x150>
               	movq	%rax, %rdx
               	movq	0x38(%rsp), %r11
               	movq	%rdx, (%r11)
               	movq	0x58(%rsp), %r10
               	addq	$0x18, %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x28(%rsp), %r10
               	movq	(%r10), %r12
               	movq	0x58(%rsp), %r15
               	addq	$0x24, %r15
               	movq	0x58(%rsp), %rdx
               	addq	$0x20, %rdx
               	movslq	(%rdx), %rsi
               	movq	%rsi, %rdx
               	addq	$0x1, %rdx
               	movslq	%edx, %rbx
               	movq	%r12, %rdi
               	movq	%r14, %r8
               	movq	%rbx, %rdx
               	movq	%r15, %rsi
               	movq	0x30(%rsp), %rcx
               	movq	0x40(%rsp), %r9
               	callq	0x400410 <.text+0x150>
               	movq	%rax, %rsi
               	movq	0x28(%rsp), %r11
               	movq	%rsi, (%r11)
               	movq	0x58(%rsp), %rbx
               	addq	$0x8, %rbx
               	movq	(%rbx), %rsi
               	movq	0x48(%rsp), %rbx
               	cmpq	%rsi, %rbx
               	jne	0x40059a <.text+0x2da>
               	movl	$0x1, %esi
               	movq	%rsi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	movq	0x58(%rsp), %rbx
               	addq	$0x18, %rbx
               	movq	(%rbx), %rsi
               	movq	0x50(%rsp), %rbx
               	cmpq	%rsi, %rbx
               	jne	0x4005de <.text+0x31e>
               	movl	$0x2, %esi
               	movq	%rsi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	movq	0x58(%rsp), %rbx
               	addq	$0x8, %rbx
               	movq	(%rbx), %rsi
               	cmpq	$0x1234abcd, %rsi       # imm = 0x1234ABCD
               	je	0x400621 <.text+0x361>
               	movl	$0x3, %esi
               	movq	%rsi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	movq	0x58(%rsp), %rbx
               	addq	$0x18, %rbx
               	movq	(%rbx), %rsi
               	cmpq	$0x1234abcd, %rsi       # imm = 0x1234ABCD
               	je	0x400664 <.text+0x3a4>
               	movl	$0x4, %esi
               	movq	%rsi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	movq	0x58(%rsp), %rbx
               	addq	$0x14, %rbx
               	movslq	(%rbx), %rsi
               	cmpq	$0x4, %rsi
               	je	0x4006a7 <.text+0x3e7>
               	movl	$0x5, %esi
               	movq	%rsi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	movq	0x58(%rsp), %rbx
               	addq	$0x24, %rbx
               	movslq	(%rbx), %rsi
               	cmpq	$0x4, %rsi
               	je	0x4006ea <.text+0x42a>
               	movl	$0x6, %esi
               	movq	%rsi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rbx, %rbx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	leaq	0xfa1c(%rip), %rbx      # 0x410150
               	leaq	0xfa3d(%rip), %r12      # 0x410178
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	0x400428 <.text+0x168>
               	movq	%rax, %r8
               	movslq	%r8d, %r12
               	cmpq	$0x0, %r12
               	je	0x4007f2 <.text+0x532>
               	leaq	0xfa1d(%rip), %r14      # 0x41017d
               	movslq	%r8d, %r12
               	leaq	0xf9e6(%rip), %r8       # 0x410150
               	movq	%r8, %rdi
               	addq	$0x8, %rdi
               	movq	(%rdi), %rbx
               	movq	%r8, %rdi
               	addq	$0x18, %rdi
               	movq	(%rdi), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	%r8, %rdi
               	addq	$0x14, %rdi
               	movslq	(%rdi), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	%r8, %rdi
               	addq	$0x24, %rdi
               	movslq	(%rdi), %r15
               	movq	%r14, %rdi
               	movq	%r15, %r9
               	movq	%rbx, %rdx
               	movq	%r12, %rsi
               	movq	0x28(%rsp), %rcx
               	movq	0x20(%rsp), %r8
               	movb	$0x0, %al
               	callq	0x40097d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %rdi
               	movl	$0x1, %edi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	0xf9bb(%rip), %r14      # 0x4101b4
               	movq	%r14, %rdi
               	movb	$0x0, %al
               	callq	0x40097d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %rdi
               	xorq	%rdi, %rdi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
               	orb	(%r9), %cl
               	jbe	0x400867 <.text+0x5a7>
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
               	jae	0x4008ee <.text+0x62e>
               	<unknown>
               	orb	(%rcx), %cl
               	jb	0x4008e5 <.text+0x625>
               	insl	%dx, %es:(%rdi)
               	outsl	(%rsi), %dx
               	je	0x4008e9 <.text+0x629>
               	andb	%ch, 0x74(%rax)
               	je	0x4008f9 <.text+0x639>
               	jae	0x4008c5 <.text+0x605>
               	<unknown>
               	<unknown>
               	imull	$0x6f632e62, 0x75(%eax,%ebp,2), %esi # imm = 0x6F632E62
               	insl	%dx, %es:(%rdi)
               	<unknown>
               	imull	$0x6d, 0x6f(%rdx), %esi
               	jns	0x400901 <.text+0x641>
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
               	callq	0x400983 <exit>
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
               	jbe	0x40092b <.text+0x66b>
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
               	jae	0x4009b2 <exit+0x2f>
               	<unknown>
               	orb	(%rcx), %cl
               	jb	0x4009a9 <exit+0x26>
               	insl	%dx, %es:(%rdi)
               	outsl	(%rsi), %dx
               	je	0x4009ad <exit+0x2a>
               	andb	%ch, 0x74(%rax)
               	je	0x4009bd <exit+0x3a>
               	jae	0x400989 <exit+0x6>
               	<unknown>
               	<unknown>
               	imull	$0x6f632e62, 0x75(%eax,%ebp,2), %esi # imm = 0x6F632E62
               	insl	%dx, %es:(%rdi)
               	<unknown>
               	imull	$0x6d, 0x6f(%rdx), %esi
               	jns	0x4009c5 <exit+0x42>
               	pushq	$0x6461622f             # imm = 0x6461622F
               	movslq	(%rsi), %ebp
               	imull	$0x0, (%eax,%eax), %esi
               	addb	%al, (%rax)
               	addb	%al, (%rax)
               	addb	%bh, %bh

<dlsym>:
               	jmpq	*0xf763(%rip)           # 0x4100e0

<printf>:
               	jmpq	*0xf765(%rip)           # 0x4100e8

<exit>:
               	jmpq	*0xf767(%rip)           # 0x4100f0
