
unsigned_char_array.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400410 <.text+0x150>
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
               	callq	0x4008a7 <dlsym>
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
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	leaq	0xfd1b(%rip), %r11      # 0x410150
               	movzbq	(%r11), %r9
               	movq	%r9, %r11
               	xorq	$0x1, %r11
               	movl	$0xffffffff, %r9d       # imm = 0xFFFFFFFF
               	andq	%r11, %r9
               	cmpq	$0x0, %r9
               	je	0x4004a6 <.text+0x1e6>
               	leaq	0xfd28(%rip), %rbx      # 0x410188
               	leaq	0xfce9(%rip), %r11      # 0x410150
               	movzbq	(%r11), %r12
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x4008ad <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r11
               	movl	$0x1, %r11d
               	movq	%r11, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfca3(%rip), %r12      # 0x410150
               	movq	%r12, %r11
               	addq	$0x5, %r11
               	movzbq	(%r11), %r12
               	movq	%r12, %r11
               	xorq	$0x6, %r11
               	movl	$0xffffffff, %r12d      # imm = 0xFFFFFFFF
               	andq	%r11, %r12
               	cmpq	$0x0, %r12
               	je	0x400531 <.text+0x271>
               	leaq	0xfcb9(%rip), %r14      # 0x41019b
               	leaq	0xfc67(%rip), %r11      # 0x410150
               	movq	%r11, %rbx
               	addq	$0x5, %rbx
               	movzbq	(%rbx), %r12
               	movq	%r14, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x4008ad <printf>
               	movslq	%eax, %rax
               	movq	%rax, %rbx
               	movl	$0x1, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfc18(%rip), %r12      # 0x410150
               	movq	%r12, %rbx
               	addq	$0x9, %rbx
               	movzbq	(%rbx), %r12
               	movq	%r12, %rbx
               	xorq	$0xa, %rbx
               	movl	$0xffffffff, %r12d      # imm = 0xFFFFFFFF
               	andq	%rbx, %r12
               	cmpq	$0x0, %r12
               	je	0x4005bd <.text+0x2fd>
               	leaq	0xfc41(%rip), %r15      # 0x4101ae
               	leaq	0xfbdc(%rip), %rbx      # 0x410150
               	movq	%rbx, %r14
               	addq	$0x9, %r14
               	movzbq	(%r14), %r12
               	movq	%r15, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x4008ad <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r14
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
               	leaq	0xfb9c(%rip), %r12      # 0x410160
               	movq	(%r12), %r14
               	cmpq	$0x64, %r14
               	je	0x400622 <.text+0x362>
               	leaq	0xfbe5(%rip), %rbx      # 0x4101c1
               	leaq	0xfb7d(%rip), %r12      # 0x410160
               	movq	(%r12), %r14
               	movq	%rbx, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x4008ad <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r12
               	movl	$0x1, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfb37(%rip), %r14      # 0x410160
               	movq	%r14, %r12
               	addq	$0x20, %r12
               	movq	(%r12), %r14
               	cmpq	$0x1f4, %r14            # imm = 0x1F4
               	je	0x400699 <.text+0x3d9>
               	leaq	0xfb89(%rip), %r15      # 0x4101d4
               	leaq	0xfb0e(%rip), %r12      # 0x410160
               	movq	%r12, %rbx
               	addq	$0x20, %rbx
               	movq	(%rbx), %r14
               	movq	%r15, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x4008ad <printf>
               	movslq	%eax, %rax
               	movq	%rax, %rbx
               	movl	$0x1, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0x5, %r14d
               	leaq	0xfaaa(%rip), %rbx      # 0x410150
               	movq	%r14, %r15
               	andq	$0xff, %r15
               	movq	%rbx, %rdi
               	addq	%r15, %rdi
               	movzbq	(%rdi), %r15
               	movq	%r15, %rdi
               	xorq	$0x6, %rdi
               	movl	$0xffffffff, %r15d      # imm = 0xFFFFFFFF
               	andq	%rdi, %r15
               	cmpq	$0x0, %r15
               	je	0x400737 <.text+0x477>
               	leaq	0xfb06(%rip), %r12      # 0x4101e7
               	leaq	0xfa68(%rip), %rdi      # 0x410150
               	movq	%r14, %rbx
               	andq	$0xff, %rbx
               	movq	%rdi, %r14
               	addq	%rbx, %r14
               	movzbq	(%r14), %r15
               	movq	%r12, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x4008ad <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r14
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
               	xorq	%r15, %r15
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
