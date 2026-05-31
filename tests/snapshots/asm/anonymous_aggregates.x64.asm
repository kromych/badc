
anonymous_aggregates.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movslq	%edi, %rbx
               	leaq	<rip>, %r9
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	addq	%r8, %r9
               	movq	(%r9), %r9
               	cmpq	$0x0, %r9
               	je	<addr>
               	leaq	<rip>, %r8
               	movq	%rbx, %r9
               	shlq	$0x3, %r9
               	addq	%r9, %r8
               	movq	(%r8), %r8
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
               	leaq	<rip>, %rdi
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	addq	$0x8, %rsi
               	leaq	<rip>, %rdi
               	movq	%rdi, (%rsi)
               	leaq	-0x18(%rbp), %r9
               	addq	$0x10, %r9
               	leaq	<rip>, %rdi
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	movq	%rbx, %rdi
               	shlq	$0x3, %rdi
               	addq	%rdi, %rsi
               	movq	(%rsi), %r14
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	leaq	<rip>, %r14
               	movq	%rbx, %r12
               	shlq	$0x3, %r12
               	addq	%r12, %r14
               	movq	(%rax), %rax
               	movq	%rax, (%r14)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	shlq	$0x3, %rbx
               	addq	%rbx, %rax
               	movq	(%rax), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %r11
               	movabsq	$0x1234567890abcdef, %rax # imm = 0x1234567890ABCDEF
               	movq	%rax, (%r11)
               	leaq	-0x8(%rbp), %r8
               	movl	(%r8), %r8d
               	movl	$0x90abcdef, %eax       # imm = 0x90ABCDEF
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	%rax, %r8
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %r8
               	addq	$0x4, %r8
               	movslq	(%r8), %r8
               	cmpq	$0x12345678, %r8        # imm = 0x12345678
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %r8
               	movl	(%r8), %r8d
               	movl	$0x90abcdef, %eax       # imm = 0x90ABCDEF
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	%rax, %r8
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %r8
               	addq	$0x4, %r8
               	movslq	(%r8), %r8
               	cmpq	$0x12345678, %r8        # imm = 0x12345678
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %r8
               	movl	$0xcafebabe, %eax       # imm = 0xCAFEBABE
               	movl	%eax, (%r8)
               	leaq	-0x8(%rbp), %r11
               	addq	$0x4, %r11
               	movl	$0xbadf00d, %r8d        # imm = 0xBADF00D
               	movl	%r8d, (%r11)
               	leaq	-0x8(%rbp), %rdi
               	movl	(%rdi), %edi
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	%rax, %rdi
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rdi
               	addq	$0x4, %rdi
               	movslq	(%rdi), %rdi
               	cmpq	$0xbadf00d, %rdi        # imm = 0xBADF00D
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rdi
               	movq	(%rdi), %rdi
               	movabsq	$0xbadf00dcafebabe, %r11 # imm = 0xBADF00DCAFEBABE
               	cmpq	%r11, %rdi
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x1, %eax
               	movl	%eax, (%rdi)
               	leaq	-0x20(%rbp), %r8
               	addq	$0x8, %r8
               	movl	$0x2a, %eax
               	movl	%eax, (%r8)
               	leaq	-0x20(%rbp), %rdi
               	addq	$0x10, %rdi
               	movl	$0x63, %eax
               	movl	%eax, (%rdi)
               	leaq	-0x20(%rbp), %r8
               	movslq	(%r8), %r8
               	cmpq	$0x1, %r8
               	je	<addr>
               	movl	$0xa, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %r8
               	addq	$0x8, %r8
               	movslq	(%r8), %r8
               	cmpq	$0x2a, %r8
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %r8
               	addq	$0x10, %r8
               	movslq	(%r8), %r8
               	cmpq	$0x63, %r8
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %r8
               	addq	$0x8, %r8
               	movabsq	$0x40091eb851eb851f, %rax # imm = 0x40091EB851EB851F
               	movq	%rax, (%r8)
               	leaq	-0x20(%rbp), %rdi
               	movslq	(%rdi), %rdi
               	cmpq	$0x1, %rdi
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rdi
               	addq	$0x10, %rdi
               	movslq	(%rdi), %rdi
               	cmpq	$0x63, %rdi
               	je	<addr>
               	movl	$0xe, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	xorq	%rdi, %rdi
               	cmpq	$0x0, %rdi
               	je	<addr>
               	movl	$0x14, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %rdi
               	movl	$0xa, %eax
               	movl	%eax, (%rdi)
               	leaq	-0x30(%rbp), %r8
               	addq	$0x4, %r8
               	movl	$0x14, %eax
               	movl	%eax, (%r8)
               	leaq	-0x30(%rbp), %rdi
               	addq	$0x8, %rdi
               	movl	$0x1e, %eax
               	movl	%eax, (%rdi)
               	leaq	-0x30(%rbp), %r8
               	addq	$0xc, %r8
               	movl	$0x28, %eax
               	movl	%eax, (%r8)
               	leaq	-0x30(%rbp), %rdi
               	movslq	(%rdi), %rdi
               	cmpq	$0xa, %rdi
               	je	<addr>
               	movl	$0x15, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %rdi
               	addq	$0x4, %rdi
               	movslq	(%rdi), %rdi
               	cmpq	$0x14, %rdi
               	je	<addr>
               	movl	$0x16, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %rdi
               	addq	$0x8, %rdi
               	movslq	(%rdi), %rdi
               	cmpq	$0x1e, %rdi
               	je	<addr>
               	movl	$0x17, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %rdi
               	addq	$0xc, %rdi
               	movslq	(%rdi), %rdi
               	cmpq	$0x28, %rdi
               	je	<addr>
               	movl	$0x18, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x40(%rbp), %rdi
               	movl	$0x7, %eax
               	movl	%eax, (%rdi)
               	leaq	-0x40(%rbp), %r8
               	addq	$0x4, %r8
               	movl	$0x1234, %eax           # imm = 0x1234
               	movw	%ax, (%r8)
               	leaq	-0x40(%rbp), %rdi
               	addq	$0x6, %rdi
               	movl	$0x5678, %eax           # imm = 0x5678
               	movswq	%ax, %rax
               	movw	%ax, (%rdi)
               	leaq	-0x40(%rbp), %r8
               	addq	$0x8, %r8
               	movl	$0x9, %eax
               	movl	%eax, (%r8)
               	leaq	-0x40(%rbp), %rdi
               	movslq	(%rdi), %rdi
               	cmpq	$0x7, %rdi
               	je	<addr>
               	movl	$0x1e, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x40(%rbp), %rdi
               	addq	$0x4, %rdi
               	movswq	(%rdi), %rdi
               	cmpq	$0x1234, %rdi           # imm = 0x1234
               	je	<addr>
               	movl	$0x1f, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x40(%rbp), %rdi
               	addq	$0x6, %rdi
               	movswq	(%rdi), %rdi
               	movl	$0x5678, %eax           # imm = 0x5678
               	movswq	%ax, %rax
               	cmpq	%rax, %rdi
               	je	<addr>
               	movl	$0x20, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x40(%rbp), %rdi
               	addq	$0x8, %rdi
               	movslq	(%rdi), %rdi
               	cmpq	$0x9, %rdi
               	je	<addr>
               	movl	$0x21, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1234, %edi           # imm = 0x1234
               	andq	$0xffff, %rdi           # imm = 0xFFFF
               	movl	$0x5678, %eax           # imm = 0x5678
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	shlq	$0x10, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	orq	%rax, %rdi
               	leaq	-0x40(%rbp), %rax
               	addq	$0x4, %rax
               	movslq	(%rax), %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rdi
               	cmpq	%rdi, %rax
               	je	<addr>
               	movl	$0x22, %edi
               	movq	%rdi, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x58(%rbp), %rax
               	movl	$0x58, %edi
               	movb	%dil, (%rax)
               	leaq	-0x58(%rbp), %r8
               	addq	$0x1, %r8
               	movl	$0x61, %edi
               	movb	%dil, (%r8)
               	leaq	-0x58(%rbp), %rax
               	addq	$0x2, %rax
               	movl	$0x62, %edi
               	movb	%dil, (%rax)
               	leaq	-0x58(%rbp), %r8
               	addq	$0x3, %r8
               	movl	$0x63, %edi
               	movb	%dil, (%r8)
               	leaq	-0x58(%rbp), %rax
               	addq	$0x4, %rax
               	movl	$0x64, %edi
               	movb	%dil, (%rax)
               	leaq	-0x58(%rbp), %r8
               	addq	$0x8, %r8
               	movabsq	$0x123456789abcdef0, %rdi # imm = 0x123456789ABCDEF0
               	movq	%rdi, (%r8)
               	leaq	-0x58(%rbp), %rax
               	movzbq	(%rax), %rax
               	xorq	$0x58, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x28, %edi
               	movq	%rdi, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x58(%rbp), %rax
               	addq	$0x1, %rax
               	movzbq	(%rax), %rax
               	xorq	$0x61, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x29, %edi
               	movq	%rdi, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x58(%rbp), %rax
               	addq	$0x2, %rax
               	movzbq	(%rax), %rax
               	xorq	$0x62, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x2a, %edi
               	movq	%rdi, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x58(%rbp), %rax
               	addq	$0x3, %rax
               	movzbq	(%rax), %rax
               	xorq	$0x63, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x2b, %edi
               	movq	%rdi, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x58(%rbp), %rax
               	addq	$0x4, %rax
               	movzbq	(%rax), %rax
               	xorq	$0x64, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x2c, %edi
               	movq	%rdi, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x58(%rbp), %rax
               	addq	$0x8, %rax
               	movq	(%rax), %rax
               	movabsq	$0x123456789abcdef0, %r11 # imm = 0x123456789ABCDEF0
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x2d, %edi
               	movq	%rdi, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
