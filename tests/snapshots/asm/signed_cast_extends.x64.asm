
signed_cast_extends.x64:	file format elf64-x86-64

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
               	movq	(%r9), %rax
               	movq	%rax, %rcx
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
               	movq	(%r12), %rax
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
               	subq	$0xe0, %rsp
               	movq	%rbx, (%rsp)
               	movl	$0xff, %r11d
               	andq	$0xff, %r11
               	movsbq	%r11b, %r11
               	movslq	%r11d, %r11
               	cmpq	$-0x1, %r11
               	je	<addr>
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x80, %r11d
               	andq	$0xff, %r11
               	movsbq	%r11b, %r11
               	movslq	%r11d, %r11
               	cmpq	$-0x80, %r11
               	je	<addr>
               	movl	$0x2, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x7f, %r11d
               	andq	$0xff, %r11
               	movsbq	%r11b, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x7f, %r11
               	je	<addr>
               	movl	$0x3, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	movl	$0xff, %r11d
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r11
               	movsbq	%r11b, %r11
               	movslq	%r11d, %r11
               	cmpq	$-0x1, %r11
               	je	<addr>
               	movl	$0x4, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x12345678, %r11d      # imm = 0x12345678
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r11
               	movsbq	%r11b, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x78, %r11
               	je	<addr>
               	movl	$0x5, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1234abff, %r11d      # imm = 0x1234ABFF
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r11
               	movsbq	%r11b, %r11
               	movslq	%r11d, %r11
               	cmpq	$-0x1, %r11
               	je	<addr>
               	movl	$0x6, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	movl	$0xffff, %r11d          # imm = 0xFFFF
               	andq	$0xffff, %r11           # imm = 0xFFFF
               	movswq	%r11w, %r11
               	movslq	%r11d, %r11
               	cmpq	$-0x1, %r11
               	je	<addr>
               	movl	$0x7, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x8000, %r11d          # imm = 0x8000
               	andq	$0xffff, %r11           # imm = 0xFFFF
               	movswq	%r11w, %r11
               	movslq	%r11d, %r11
               	cmpq	$-0x8000, %r11          # imm = 0x8000
               	je	<addr>
               	movl	$0x8, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x12345678, %r11d      # imm = 0x12345678
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r11
               	movswq	%r11w, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x5678, %r11           # imm = 0x5678
               	je	<addr>
               	movl	$0x9, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1234ffff, %r11d      # imm = 0x1234FFFF
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r11
               	movswq	%r11w, %r11
               	movslq	%r11d, %r11
               	cmpq	$-0x1, %r11
               	je	<addr>
               	movl	$0xa, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	movabsq	$-0x2a, %r11
               	movsbq	%r11b, %r11
               	movslq	%r11d, %r11
               	cmpq	$-0x2a, %r11
               	je	<addr>
               	movl	$0xb, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xb8(%rbp), %r11
               	movl	$0xff, %eax
               	movb	%al, (%r11)
               	leaq	-0xb8(%rbp), %r8
               	addq	$0x1, %r8
               	movl	$0x42, %eax
               	movb	%al, (%r8)
               	leaq	-0xb8(%rbp), %r11
               	addq	$0x2, %r11
               	movl	$0x10, %eax
               	movb	%al, (%r11)
               	leaq	-0xb8(%rbp), %r8
               	movzbq	(%r8), %rax
               	movsbq	%al, %rax
               	movslq	%eax, %rax
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0xc, %r8d
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xb8(%rbp), %rax
               	movzbq	(%rax), %r8
               	movsbq	%r8b, %r8
               	shlq	$0x8, %r8
               	movslq	%r8d, %r8
               	leaq	-0xb8(%rbp), %rax
               	addq	$0x1, %rax
               	movzbq	(%rax), %r11
               	orq	%r11, %r8
               	movslq	%r8d, %r8
               	cmpq	$-0xbe, %r8
               	je	<addr>
               	movl	$0xd, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rbx
               	movq	%rbx, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
