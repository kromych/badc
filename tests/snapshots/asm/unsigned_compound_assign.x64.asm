
unsigned_compound_assign.x64:	file format elf64-x86-64

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
               	callq	0x400907 <dlsym>
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
               	subq	$0x80, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movl	$0x64, %r11d
               	movl	%r11d, -0x8(%rbp)
               	leaq	-0x8(%rbp), %r9
               	movl	(%r9), %r11d
               	movq	%r11, %r8
               	addq	$0x5, %r8
               	movl	%r8d, (%r9)
               	movl	-0x8(%rbp), %r11d
               	movq	%r11, %r8
               	xorq	$0x69, %r8
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r8, %r11
               	cmpq	$0x0, %r11
               	je	0x4004b6 <.text+0x1f6>
               	leaq	0xfcd9(%rip), %rbx      # 0x410150
               	movl	-0x8(%rbp), %r12d
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x40090d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r9
               	movl	$0x1, %r9d
               	movq	%r9, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %r12
               	movl	(%r12), %r9d
               	movq	%r9, %rbx
               	subq	$0x3, %rbx
               	movl	%ebx, (%r12)
               	movl	-0x8(%rbp), %r9d
               	movq	%r9, %rbx
               	xorq	$0x66, %rbx
               	movl	$0xffffffff, %r9d       # imm = 0xFFFFFFFF
               	andq	%rbx, %r9
               	cmpq	$0x0, %r9
               	je	0x400536 <.text+0x276>
               	leaq	0xfc6f(%rip), %r14      # 0x410166
               	movl	-0x8(%rbp), %r15d
               	movq	%r14, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40090d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r12
               	movl	$0x1, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movl	$0x3e8, %r15d           # imm = 0x3E8
               	movq	%r15, -0x10(%rbp)
               	leaq	-0x10(%rbp), %r12
               	movq	(%r12), %r15
               	movq	%r15, %r14
               	addq	$0x19f, %r14            # imm = 0x19F
               	movq	%r14, (%r12)
               	movq	-0x10(%rbp), %r15
               	cmpq	$0x587, %r15            # imm = 0x587
               	je	0x4005ad <.text+0x2ed>
               	leaq	0xfc0e(%rip), %rbx      # 0x41017c
               	movq	-0x10(%rbp), %r15
               	movq	%rbx, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40090d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r12
               	movl	$0x1, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movl	$0x41c, %r15d           # imm = 0x41C
               	movl	%r15d, -0x18(%rbp)
               	movl	$0x19f, %r12d           # imm = 0x19F
               	movslq	%r12d, %r12
               	leaq	-0x18(%rbp), %r15
               	movl	(%r15), %ebx
               	movslq	%r12d, %rdi
               	movq	%rbx, %r12
               	addq	%rdi, %r12
               	movl	%r12d, (%r15)
               	movl	-0x18(%rbp), %edi
               	movq	%rdi, %r12
               	xorq	$0x5bb, %r12            # imm = 0x5BB
               	movl	$0xffffffff, %edi       # imm = 0xFFFFFFFF
               	andq	%r12, %rdi
               	cmpq	$0x0, %rdi
               	je	0x40063a <.text+0x37a>
               	leaq	0xfb99(%rip), %r14      # 0x410195
               	movl	-0x18(%rbp), %ebx
               	movq	%r14, %rdi
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x40090d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r15
               	movl	$0x1, %r15d
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movl	$0xc8, %ebx
               	movb	%bl, -0x28(%rbp)
               	leaq	-0x28(%rbp), %r15
               	movzbq	(%r15), %rbx
               	movq	%rbx, %r14
               	addq	$0x3c, %r14
               	movb	%r14b, (%r15)
               	movzbq	-0x28(%rbp), %rbx
               	movq	%rbx, %r14
               	xorq	$0x4, %r14
               	movl	$0xffffffff, %ebx       # imm = 0xFFFFFFFF
               	andq	%r14, %rbx
               	cmpq	$0x0, %rbx
               	je	0x4006c3 <.text+0x403>
               	leaq	0xfb33(%rip), %r12      # 0x4101b6
               	movzbq	-0x28(%rbp), %rbx
               	movq	%r12, %rdi
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x40090d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r15
               	movl	$0x1, %r15d
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x40(%rbp), %rbx
               	xorq	%r15, %r15
               	movl	%r15d, (%rbx)
               	leaq	-0x40(%rbp), %r12
               	movq	%r12, %r15
               	addq	$0x4, %r15
               	movl	$0xa, %r12d
               	movl	%r12d, (%r15)
               	leaq	-0x40(%rbp), %rbx
               	movq	%rbx, %r12
               	addq	$0x8, %r12
               	movl	$0x14, %ebx
               	movl	%ebx, (%r12)
               	leaq	-0x40(%rbp), %r15
               	movq	%r15, %rbx
               	addq	$0xc, %rbx
               	movl	$0x1e, %r15d
               	movl	%r15d, (%rbx)
               	leaq	-0x40(%rbp), %r12
               	movq	%r12, %r15
               	addq	$0x10, %r15
               	movl	$0x28, %r12d
               	movl	%r12d, (%r15)
               	leaq	-0x40(%rbp), %rbx
               	movq	%rbx, -0x48(%rbp)
               	leaq	-0x48(%rbp), %r12
               	movq	(%r12), %rbx
               	movq	%rbx, %r15
               	addq	$0xc, %r15
               	movq	%r15, (%r12)
               	movq	-0x48(%rbp), %rbx
               	movslq	(%rbx), %r15
               	cmpq	$0x1e, %r15
               	je	0x4007a3 <.text+0x4e3>
               	leaq	0xfa70(%rip), %r14      # 0x4101d2
               	movq	-0x48(%rbp), %rbx
               	movslq	(%rbx), %r15
               	movq	%r14, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40090d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %rbx
               	movl	$0x1, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	xorq	%r15, %r15
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
