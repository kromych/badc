
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
               	movq	(%r9), %r8
               	cmpq	$0x0, %r8
               	je	<addr>
               	leaq	<rip>, %r9
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
               	movq	(%rax), %r12
               	movq	%r12, (%r14)
               	jmp	<addr>
               	leaq	<rip>, %r12
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
               	movl	(%r8), %eax
               	movl	$0x90abcdef, %r8d       # imm = 0x90ABCDEF
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r8
               	cmpq	%r8, %rax
               	je	<addr>
               	movl	$0x2, %r8d
               	movq	%r8, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	addq	$0x4, %rax
               	movslq	(%rax), %r8
               	cmpq	$0x12345678, %r8        # imm = 0x12345678
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %r8
               	movl	(%r8), %eax
               	movl	$0x90abcdef, %r8d       # imm = 0x90ABCDEF
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r8
               	cmpq	%r8, %rax
               	je	<addr>
               	movl	$0x4, %r8d
               	movq	%r8, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	addq	$0x4, %rax
               	movslq	(%rax), %r8
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
               	movl	(%rdi), %r8d
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	%rax, %r8
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %r8
               	addq	$0x4, %r8
               	movslq	(%r8), %rax
               	cmpq	$0xbadf00d, %rax        # imm = 0xBADF00D
               	je	<addr>
               	movl	$0x7, %r8d
               	movq	%r8, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movq	(%rax), %r8
               	movabsq	$0xbadf00dcafebabe, %r11 # imm = 0xBADF00DCAFEBABE
               	cmpq	%r11, %r8
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %r8
               	movl	$0x1, %eax
               	movl	%eax, (%r8)
               	leaq	-0x20(%rbp), %rdi
               	addq	$0x8, %rdi
               	movl	$0x2a, %eax
               	movl	%eax, (%rdi)
               	leaq	-0x20(%rbp), %r8
               	addq	$0x10, %r8
               	movl	$0x63, %eax
               	movl	%eax, (%r8)
               	leaq	-0x20(%rbp), %rdi
               	movslq	(%rdi), %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0xa, %edi
               	movq	%rdi, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rax
               	addq	$0x8, %rax
               	movslq	(%rax), %rdi
               	cmpq	$0x2a, %rdi
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rdi
               	addq	$0x10, %rdi
               	movslq	(%rdi), %rax
               	cmpq	$0x63, %rax
               	je	<addr>
               	movl	$0xc, %edi
               	movq	%rdi, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rax
               	addq	$0x8, %rax
               	movabsq	$0x40091eb851eb851f, %rdi # imm = 0x40091EB851EB851F
               	movq	%rdi, (%rax)
               	leaq	-0x20(%rbp), %r8
               	movslq	(%r8), %rdi
               	cmpq	$0x1, %rdi
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rdi
               	addq	$0x10, %rdi
               	movslq	(%rdi), %rax
               	cmpq	$0x63, %rax
               	je	<addr>
               	movl	$0xe, %edi
               	movq	%rdi, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x14, %edi
               	movq	%rdi, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %rax
               	movl	$0xa, %edi
               	movl	%edi, (%rax)
               	leaq	-0x30(%rbp), %r8
               	addq	$0x4, %r8
               	movl	$0x14, %edi
               	movl	%edi, (%r8)
               	leaq	-0x30(%rbp), %rax
               	addq	$0x8, %rax
               	movl	$0x1e, %edi
               	movl	%edi, (%rax)
               	leaq	-0x30(%rbp), %r8
               	addq	$0xc, %r8
               	movl	$0x28, %edi
               	movl	%edi, (%r8)
               	leaq	-0x30(%rbp), %rax
               	movslq	(%rax), %rdi
               	cmpq	$0xa, %rdi
               	je	<addr>
               	movl	$0x15, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %rdi
               	addq	$0x4, %rdi
               	movslq	(%rdi), %rax
               	cmpq	$0x14, %rax
               	je	<addr>
               	movl	$0x16, %edi
               	movq	%rdi, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %rax
               	addq	$0x8, %rax
               	movslq	(%rax), %rdi
               	cmpq	$0x1e, %rdi
               	je	<addr>
               	movl	$0x17, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %rdi
               	addq	$0xc, %rdi
               	movslq	(%rdi), %rax
               	cmpq	$0x28, %rax
               	je	<addr>
               	movl	$0x18, %edi
               	movq	%rdi, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x40(%rbp), %rax
               	movl	$0x7, %edi
               	movl	%edi, (%rax)
               	leaq	-0x40(%rbp), %r8
               	addq	$0x4, %r8
               	movl	$0x1234, %edi           # imm = 0x1234
               	movw	%di, (%r8)
               	leaq	-0x40(%rbp), %rax
               	addq	$0x6, %rax
               	movl	$0x5678, %edi           # imm = 0x5678
               	movswq	%di, %rdi
               	movw	%di, (%rax)
               	leaq	-0x40(%rbp), %r8
               	addq	$0x8, %r8
               	movl	$0x9, %edi
               	movl	%edi, (%r8)
               	leaq	-0x40(%rbp), %rax
               	movslq	(%rax), %rdi
               	cmpq	$0x7, %rdi
               	je	<addr>
               	movl	$0x1e, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x40(%rbp), %rdi
               	addq	$0x4, %rdi
               	movswq	(%rdi), %rax
               	cmpq	$0x1234, %rax           # imm = 0x1234
               	je	<addr>
               	movl	$0x1f, %edi
               	movq	%rdi, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x40(%rbp), %rax
               	addq	$0x6, %rax
               	movswq	(%rax), %rdi
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
               	movslq	(%rdi), %rax
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0x21, %edi
               	movq	%rdi, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1234, %eax           # imm = 0x1234
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movl	$0x5678, %edi           # imm = 0x5678
               	andq	$0xffff, %rdi           # imm = 0xFFFF
               	shlq	$0x10, %rdi
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rdi
               	orq	%rdi, %rax
               	leaq	-0x40(%rbp), %rdi
               	addq	$0x4, %rdi
               	movslq	(%rdi), %r8
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r8
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	%rax, %r8
               	je	<addr>
               	movl	$0x22, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x58(%rbp), %r8
               	movl	$0x58, %eax
               	movb	%al, (%r8)
               	leaq	-0x58(%rbp), %rdi
               	addq	$0x1, %rdi
               	movl	$0x61, %eax
               	movb	%al, (%rdi)
               	leaq	-0x58(%rbp), %r8
               	addq	$0x2, %r8
               	movl	$0x62, %eax
               	movb	%al, (%r8)
               	leaq	-0x58(%rbp), %rdi
               	addq	$0x3, %rdi
               	movl	$0x63, %eax
               	movb	%al, (%rdi)
               	leaq	-0x58(%rbp), %r8
               	addq	$0x4, %r8
               	movl	$0x64, %eax
               	movb	%al, (%r8)
               	leaq	-0x58(%rbp), %rdi
               	addq	$0x8, %rdi
               	movabsq	$0x123456789abcdef0, %rax # imm = 0x123456789ABCDEF0
               	movq	%rax, (%rdi)
               	leaq	-0x58(%rbp), %r8
               	movzbq	(%r8), %rax
               	xorq	$0x58, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x28, %r8d
               	movq	%r8, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x58(%rbp), %rax
               	addq	$0x1, %rax
               	movzbq	(%rax), %r8
               	xorq	$0x61, %r8
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r8
               	cmpq	$0x0, %r8
               	je	<addr>
               	movl	$0x29, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x58(%rbp), %r8
               	addq	$0x2, %r8
               	movzbq	(%r8), %rax
               	xorq	$0x62, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x2a, %r8d
               	movq	%r8, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x58(%rbp), %rax
               	addq	$0x3, %rax
               	movzbq	(%rax), %r8
               	xorq	$0x63, %r8
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r8
               	cmpq	$0x0, %r8
               	je	<addr>
               	movl	$0x2b, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x58(%rbp), %r8
               	addq	$0x4, %r8
               	movzbq	(%r8), %rax
               	xorq	$0x64, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x2c, %r8d
               	movq	%r8, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x58(%rbp), %rax
               	addq	$0x8, %rax
               	movq	(%rax), %r8
               	movabsq	$0x123456789abcdef0, %r11 # imm = 0x123456789ABCDEF0
               	cmpq	%r11, %r8
               	je	<addr>
               	movl	$0x2d, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	xorq	%r8, %r8
               	movq	%r8, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
