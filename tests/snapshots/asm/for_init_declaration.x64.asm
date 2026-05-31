
for_init_declaration.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x4006ec <.text+0x42c>
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
               	callq	0x400a47 <dlsym>
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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	xorq	%r11, %r11
               	movl	%r11d, -0x8(%rbp)
               	movl	%r11d, -0x10(%rbp)
               	jmp	0x40042b <.text+0x16b>
               	movslq	-0x10(%rbp), %r11
               	cmpq	$0xa, %r11
               	jge	0x400473 <.text+0x1b3>
               	jmp	0x40045a <.text+0x19a>
               	leaq	-0x10(%rbp), %r11
               	movslq	(%r11), %r9
               	movq	%r9, %r8
               	addq	$0x1, %r8
               	movl	%r8d, (%r11)
               	jmp	0x40042b <.text+0x16b>
               	leaq	-0x8(%rbp), %r8
               	movslq	(%r8), %r9
               	movslq	-0x10(%rbp), %r11
               	movq	%r9, %rdi
               	addq	%r11, %rdi
               	movl	%edi, (%r8)
               	jmp	0x400441 <.text+0x181>
               	movslq	-0x8(%rbp), %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	xorq	%r11, %r11
               	movl	%r11d, -0x8(%rbp)
               	movl	$0xa, %r9d
               	movl	%r9d, -0x18(%rbp)
               	jmp	0x4004a1 <.text+0x1e1>
               	movslq	-0x10(%rbp), %r9
               	movslq	-0x18(%rbp), %r11
               	cmpq	%r11, %r9
               	jge	0x40050a <.text+0x24a>
               	jmp	0x4004e4 <.text+0x224>
               	leaq	-0x10(%rbp), %r11
               	movslq	(%r11), %r8
               	movq	%r8, %r9
               	addq	$0x1, %r9
               	movl	%r9d, (%r11)
               	leaq	-0x18(%rbp), %r8
               	movslq	(%r8), %r9
               	movq	%r9, %r11
               	addq	$-0x1, %r11
               	movl	%r11d, (%r8)
               	jmp	0x4004a1 <.text+0x1e1>
               	leaq	-0x8(%rbp), %r11
               	movslq	(%r11), %r9
               	movslq	-0x10(%rbp), %r8
               	movslq	-0x18(%rbp), %rdi
               	movq	%r8, %rsi
               	addq	%rdi, %rsi
               	movslq	%esi, %rsi
               	movq	%r9, %rdi
               	addq	%rsi, %rdi
               	movl	%edi, (%r11)
               	jmp	0x4004b7 <.text+0x1f7>
               	movslq	-0x8(%rbp), %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	$0x2a, %r11d
               	xorq	%r9, %r9
               	movl	%r9d, -0x10(%rbp)
               	jmp	0x400534 <.text+0x274>
               	movslq	-0x10(%rbp), %r9
               	cmpq	$0x3, %r9
               	jge	0x400568 <.text+0x2a8>
               	jmp	0x400563 <.text+0x2a3>
               	leaq	-0x10(%rbp), %r9
               	movslq	(%r9), %r8
               	movq	%r8, %rdi
               	addq	$0x1, %rdi
               	movl	%edi, (%r9)
               	jmp	0x400534 <.text+0x274>
               	jmp	0x40054a <.text+0x28a>
               	movslq	%r11d, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	xorq	%r11, %r11
               	movl	%r11d, -0x8(%rbp)
               	movl	%r11d, -0x10(%rbp)
               	jmp	0x40058f <.text+0x2cf>
               	movslq	-0x10(%rbp), %r11
               	cmpq	$0x5, %r11
               	jge	0x4005d7 <.text+0x317>
               	jmp	0x4005be <.text+0x2fe>
               	leaq	-0x10(%rbp), %r11
               	movslq	(%r11), %r9
               	movq	%r9, %r8
               	addq	$0x1, %r8
               	movl	%r8d, (%r11)
               	jmp	0x40058f <.text+0x2cf>
               	leaq	-0x8(%rbp), %r8
               	movslq	(%r8), %r9
               	movslq	-0x10(%rbp), %r11
               	movq	%r9, %rdi
               	addq	%r11, %rdi
               	movl	%edi, (%r8)
               	jmp	0x4005a5 <.text+0x2e5>
               	movl	$0xa, %edi
               	movl	%edi, -0x18(%rbp)
               	jmp	0x4005e4 <.text+0x324>
               	movslq	-0x18(%rbp), %rdi
               	cmpq	$0xd, %rdi
               	jge	0x40062c <.text+0x36c>
               	jmp	0x400613 <.text+0x353>
               	leaq	-0x18(%rbp), %rdi
               	movslq	(%rdi), %r11
               	movq	%r11, %r8
               	addq	$0x1, %r8
               	movl	%r8d, (%rdi)
               	jmp	0x4005e4 <.text+0x324>
               	leaq	-0x8(%rbp), %r8
               	movslq	(%r8), %r11
               	movslq	-0x18(%rbp), %rdi
               	movq	%r11, %r9
               	addq	%rdi, %r9
               	movl	%r9d, (%r8)
               	jmp	0x4005fa <.text+0x33a>
               	movslq	-0x8(%rbp), %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	0xfb05(%rip), %r11      # 0x410150
               	xorq	%r9, %r9
               	movl	$0x1, %r8d
               	movl	%r8d, (%r11)
               	movl	$0x4, %edi
               	movq	%r11, %r8
               	addq	$0x4, %r8
               	movl	$0x2, %esi
               	movl	%esi, (%r8)
               	movq	%r11, %rdx
               	addq	$0x8, %rdx
               	movl	%edi, (%rdx)
               	movl	%r9d, -0x8(%rbp)
               	movq	%r11, -0x10(%rbp)
               	jmp	0x400687 <.text+0x3c7>
               	movq	-0x10(%rbp), %r11
               	leaq	0xfabe(%rip), %rsi      # 0x410150
               	movq	%rsi, %r9
               	addq	$0xc, %r9
               	cmpq	%r9, %r11
               	jge	0x4006df <.text+0x41f>
               	jmp	0x4006c3 <.text+0x403>
               	leaq	-0x10(%rbp), %r9
               	movq	(%r9), %rsi
               	movq	%rsi, %r11
               	addq	$0x4, %r11
               	movq	%r11, (%r9)
               	jmp	0x400687 <.text+0x3c7>
               	leaq	-0x8(%rbp), %r11
               	movslq	(%r11), %rsi
               	movq	-0x10(%rbp), %r9
               	movslq	(%r9), %rdx
               	movq	%rsi, %r9
               	addq	%rdx, %r9
               	movl	%r9d, (%r11)
               	jmp	0x4006aa <.text+0x3ea>
               	movslq	-0x8(%rbp), %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	callq	0x400410 <.text+0x150>
               	movq	%rax, %r11
               	cmpq	$0x2d, %r11
               	je	0x400769 <.text+0x4a9>
               	leaq	0xfa3a(%rip), %rbx      # 0x410160
               	callq	0x400410 <.text+0x150>
               	movq	%rax, %r12
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x400a4d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r8
               	movl	$0x1, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	callq	0x400480 <.text+0x1c0>
               	movq	%rax, %r12
               	cmpq	$0x32, %r12
               	je	0x4007c8 <.text+0x508>
               	leaq	0xf9f0(%rip), %r15      # 0x410175
               	callq	0x400480 <.text+0x1c0>
               	movq	%rax, %r12
               	movq	%r15, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x400a4d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %rbx
               	movl	$0x2, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	callq	0x400517 <.text+0x257>
               	movq	%rax, %r12
               	cmpq	$0x2a, %r12
               	je	0x400827 <.text+0x567>
               	leaq	0xf9a6(%rip), %rbx      # 0x41018a
               	callq	0x400517 <.text+0x257>
               	movq	%rax, %r12
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x400a4d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r15
               	movl	$0x3, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	callq	0x400574 <.text+0x2b4>
               	movq	%rax, %r12
               	cmpq	$0x2b, %r12
               	je	0x400886 <.text+0x5c6>
               	leaq	0xf95b(%rip), %r15      # 0x41019e
               	callq	0x400574 <.text+0x2b4>
               	movq	%rax, %r12
               	movq	%r15, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x400a4d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %rbx
               	movl	$0x4, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	callq	0x400639 <.text+0x379>
               	movq	%rax, %r12
               	cmpq	$0x7, %r12
               	je	0x4008e5 <.text+0x625>
               	leaq	0xf914(%rip), %rbx      # 0x4101b6
               	callq	0x400639 <.text+0x379>
               	movq	%rax, %r12
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x400a4d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r15
               	movl	$0x5, %r15d
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%r12, %r12
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
