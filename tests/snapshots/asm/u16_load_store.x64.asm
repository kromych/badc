
u16_load_store.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x4003f6 <.text+0x136>
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
               	addq	%r8, %r9
               	movq	(%r9), %r8
               	cmpq	$0x0, %r8
               	je	0x400345 <.text+0x85>
               	leaq	0xfde5(%rip), %r9       # 0x410100
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
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
               	leaq	0xfdc5(%rip), %rdi      # 0x410118
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	addq	$0x8, %rsi
               	leaq	0xfdb6(%rip), %rdi      # 0x41011e
               	movq	%rdi, (%rsi)
               	leaq	-0x18(%rbp), %r9
               	addq	$0x10, %r9
               	leaq	0xfda8(%rip), %rdi      # 0x410125
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	movq	%rbx, %rdi
               	shlq	$0x3, %rdi
               	addq	%rdi, %rsi
               	movq	(%rsi), %r14
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	xorl	%eax, %eax
               	callq	0x4007a7 <dlsym>
               	cmpq	$0x0, %rax
               	je	0x4003c7 <.text+0x107>
               	leaq	0xfd4e(%rip), %r14      # 0x410100
               	movq	%rbx, %r12
               	shlq	$0x3, %r12
               	addq	%r12, %r14
               	movq	(%rax), %r12
               	movq	%r12, (%r14)
               	jmp	0x4003c7 <.text+0x107>
               	leaq	0xfd32(%rip), %r12      # 0x410100
               	shlq	$0x3, %rbx
               	addq	%rbx, %r12
               	movq	(%r12), %rbx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x70, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	leaq	-0x10(%rbp), %r11
               	leaq	0xfd3c(%rip), %r9       # 0x410156
               	pushq	%rax
               	movq	(%r9), %rax
               	movq	%rax, (%r11)
               	movzbq	0x8(%r9), %rax
               	movb	%al, 0x8(%r11)
               	movzbq	0x9(%r9), %rax
               	movb	%al, 0x9(%r11)
               	popq	%rax
               	movq	%r11, %r8
               	leaq	-0x20(%rbp), %rbx
               	xorq	%r12, %r12
               	movl	$0xa, %r14d
               	movq	%rbx, %rdi
               	movq	%r14, %rdx
               	movq	%r12, %rsi
               	xorl	%eax, %eax
               	callq	0x4007ad <memset>
               	leaq	-0x20(%rbp), %rax
               	addq	$0x2, %rax
               	movl	$0x4241, %r14d          # imm = 0x4241
               	movw	%r14w, (%rax)
               	leaq	-0x20(%rbp), %r12
               	movzbq	(%r12), %r14
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r14
               	cmpq	$0x0, %r14
               	setne	%r14b
               	movzbq	%r14b, %r14
               	movq	%r14, -0x40(%rbp)
               	cmpq	$0x0, %r14
               	jne	0x4004cc <.text+0x20c>
               	leaq	-0x20(%rbp), %r12
               	addq	$0x1, %r12
               	movzbq	(%r12), %r14
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r14
               	cmpq	$0x0, %r14
               	setne	%r14b
               	movzbq	%r14b, %r14
               	movq	%r14, -0x40(%rbp)
               	jmp	0x4004cc <.text+0x20c>
               	movq	-0x40(%rbp), %r14
               	cmpq	$0x0, %r14
               	je	0x400500 <.text+0x240>
               	movl	$0x1, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %r14
               	addq	$0x2, %r14
               	movzbq	(%r14), %r12
               	xorq	$0x41, %r12
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r12
               	cmpq	$0x0, %r12
               	setne	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0x48(%rbp)
               	cmpq	$0x0, %r12
               	jne	0x400576 <.text+0x2b6>
               	leaq	-0x20(%rbp), %r14
               	addq	$0x3, %r14
               	movzbq	(%r14), %r12
               	xorq	$0x42, %r12
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r12
               	cmpq	$0x0, %r12
               	setne	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0x48(%rbp)
               	jmp	0x400576 <.text+0x2b6>
               	movq	-0x48(%rbp), %r12
               	cmpq	$0x0, %r12
               	je	0x4005aa <.text+0x2ea>
               	movl	$0x2, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %r12
               	addq	$0x4, %r12
               	movzbq	(%r12), %r14
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r14
               	cmpq	$0x0, %r14
               	je	0x4005f3 <.text+0x333>
               	movl	$0x3, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %r14
               	addq	$0x1, %r14
               	movzwq	(%r14), %r12
               	andq	$0xffff, %r12           # imm = 0xFFFF
               	xorq	$0x4342, %r12           # imm = 0x4342
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r12
               	cmpq	$0x0, %r12
               	je	0x400649 <.text+0x389>
               	movl	$0x4, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	xorq	%r12, %r12
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
