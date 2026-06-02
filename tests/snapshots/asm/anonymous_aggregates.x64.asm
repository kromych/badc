
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
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
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
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r9
               	xorq	%rdi, %rdi
               	leaq	<rip>, %r8
               	movq	%r8, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	addq	$0x8, %rsi
               	leaq	<rip>, %r8
               	movq	%r8, (%rsi)
               	leaq	-0x18(%rbp), %r9
               	addq	$0x10, %r9
               	leaq	<rip>, %r8
               	movq	%r8, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	addq	%r8, %rsi
               	movq	(%rsi), %r8
               	movq	%r8, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	leaq	<rip>, %rdi
               	movq	%rbx, %rsi
               	shlq	$0x3, %rsi
               	addq	%rsi, %rdi
               	movq	(%rax), %rax
               	movq	%rax, (%rdi)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	shlq	$0x3, %rbx
               	addq	%rbx, %rax
               	movq	(%rax), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	jmp	<addr>
               	movl	$0x1, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %r11
               	movabsq	$0x1234567890abcdef, %rax # imm = 0x1234567890ABCDEF
               	movq	%rax, (%r11)
               	leaq	-0x8(%rbp), %r8
               	movl	(%r8), %r8d
               	movl	$0x90abcdef, %r11d      # imm = 0x90ABCDEF
               	cmpq	%r11, %r8
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
               	movl	$0x90abcdef, %r11d      # imm = 0x90ABCDEF
               	cmpq	%r11, %r8
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
               	movl	$0xbadf00d, %eax        # imm = 0xBADF00D
               	movl	%eax, (%r11)
               	leaq	-0x8(%rbp), %r8
               	movl	(%r8), %r8d
               	movl	$0xcafebabe, %r11d      # imm = 0xCAFEBABE
               	cmpq	%r11, %r8
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %r8
               	addq	$0x4, %r8
               	movslq	(%r8), %r8
               	cmpq	$0xbadf00d, %r8         # imm = 0xBADF00D
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %r8
               	movq	(%r8), %r8
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
               	leaq	-0x20(%rbp), %r11
               	addq	$0x8, %r11
               	movl	$0x2a, %eax
               	movl	%eax, (%r11)
               	leaq	-0x20(%rbp), %r8
               	addq	$0x10, %r8
               	movl	$0x63, %eax
               	movl	%eax, (%r8)
               	leaq	-0x20(%rbp), %r11
               	movslq	(%r11), %r11
               	cmpq	$0x1, %r11
               	je	<addr>
               	movl	$0xa, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %r11
               	addq	$0x8, %r11
               	movslq	(%r11), %r11
               	cmpq	$0x2a, %r11
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %r11
               	addq	$0x10, %r11
               	movslq	(%r11), %r11
               	cmpq	$0x63, %r11
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %r11
               	addq	$0x8, %r11
               	movabsq	$0x40091eb851eb851f, %rax # imm = 0x40091EB851EB851F
               	movq	%rax, (%r11)
               	leaq	-0x20(%rbp), %r8
               	movslq	(%r8), %r8
               	cmpq	$0x1, %r8
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %r8
               	addq	$0x10, %r8
               	movslq	(%r8), %r8
               	cmpq	$0x63, %r8
               	je	<addr>
               	movl	$0xe, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0x14, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %r8
               	movl	$0xa, %eax
               	movl	%eax, (%r8)
               	leaq	-0x30(%rbp), %r11
               	addq	$0x4, %r11
               	movl	$0x14, %eax
               	movl	%eax, (%r11)
               	leaq	-0x30(%rbp), %r8
               	addq	$0x8, %r8
               	movl	$0x1e, %eax
               	movl	%eax, (%r8)
               	leaq	-0x30(%rbp), %r11
               	addq	$0xc, %r11
               	movl	$0x28, %eax
               	movl	%eax, (%r11)
               	leaq	-0x30(%rbp), %r8
               	movslq	(%r8), %r8
               	cmpq	$0xa, %r8
               	je	<addr>
               	movl	$0x15, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %r8
               	addq	$0x4, %r8
               	movslq	(%r8), %r8
               	cmpq	$0x14, %r8
               	je	<addr>
               	movl	$0x16, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %r8
               	addq	$0x8, %r8
               	movslq	(%r8), %r8
               	cmpq	$0x1e, %r8
               	je	<addr>
               	movl	$0x17, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %r8
               	addq	$0xc, %r8
               	movslq	(%r8), %r8
               	cmpq	$0x28, %r8
               	je	<addr>
               	movl	$0x18, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x40(%rbp), %r8
               	movl	$0x7, %eax
               	movl	%eax, (%r8)
               	leaq	-0x40(%rbp), %r11
               	addq	$0x4, %r11
               	movl	$0x1234, %eax           # imm = 0x1234
               	movw	%ax, (%r11)
               	leaq	-0x40(%rbp), %r8
               	addq	$0x6, %r8
               	movl	$0x5678, %eax           # imm = 0x5678
               	movw	%ax, (%r8)
               	leaq	-0x40(%rbp), %r11
               	addq	$0x8, %r11
               	movl	$0x9, %eax
               	movl	%eax, (%r11)
               	leaq	-0x40(%rbp), %r8
               	movslq	(%r8), %r8
               	cmpq	$0x7, %r8
               	je	<addr>
               	movl	$0x1e, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x40(%rbp), %r8
               	addq	$0x4, %r8
               	movswq	(%r8), %r8
               	cmpq	$0x1234, %r8            # imm = 0x1234
               	je	<addr>
               	movl	$0x1f, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x40(%rbp), %r8
               	addq	$0x6, %r8
               	movswq	(%r8), %r8
               	cmpq	$0x5678, %r8            # imm = 0x5678
               	je	<addr>
               	movl	$0x20, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x40(%rbp), %r8
               	addq	$0x8, %r8
               	movslq	(%r8), %r8
               	cmpq	$0x9, %r8
               	je	<addr>
               	movl	$0x21, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movl	$0x56781234, %r8d       # imm = 0x56781234
               	leaq	-0x40(%rbp), %rax
               	addq	$0x4, %rax
               	movslq	(%rax), %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	%r8, %rax
               	je	<addr>
               	movl	$0x22, %r8d
               	movq	%r8, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x58(%rbp), %rax
               	movl	$0x58, %r8d
               	movb	%r8b, (%rax)
               	leaq	-0x58(%rbp), %r11
               	addq	$0x1, %r11
               	movl	$0x61, %r8d
               	movb	%r8b, (%r11)
               	leaq	-0x58(%rbp), %rax
               	addq	$0x2, %rax
               	movl	$0x62, %r8d
               	movb	%r8b, (%rax)
               	leaq	-0x58(%rbp), %r11
               	addq	$0x3, %r11
               	movl	$0x63, %r8d
               	movb	%r8b, (%r11)
               	leaq	-0x58(%rbp), %rax
               	addq	$0x4, %rax
               	movl	$0x64, %r8d
               	movb	%r8b, (%rax)
               	leaq	-0x58(%rbp), %r11
               	addq	$0x8, %r11
               	movabsq	$0x123456789abcdef0, %r8 # imm = 0x123456789ABCDEF0
               	movq	%r8, (%r11)
               	leaq	-0x58(%rbp), %rax
               	movzbq	(%rax), %rax
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
               	movzbq	(%rax), %rax
               	xorq	$0x61, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x29, %r8d
               	movq	%r8, %rax
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
               	movl	$0x2a, %r8d
               	movq	%r8, %rax
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
               	movl	$0x2b, %r8d
               	movq	%r8, %rax
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
               	movl	$0x2c, %r8d
               	movq	%r8, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x58(%rbp), %rax
               	addq	$0x8, %rax
               	movq	(%rax), %rax
               	movabsq	$0x123456789abcdef0, %r11 # imm = 0x123456789ABCDEF0
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x2d, %r8d
               	movq	%r8, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
