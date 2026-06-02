
two_d_array_param_indexing.x64:	file format elf64-x86-64

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
               	movq	%r12, 0x8(%rsp)
               	movslq	%edi, %rbx
               	leaq	<rip>, %r12
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	addq	%r12, %r8
               	movq	(%r8), %r8
               	cmpq	$0x0, %r8
               	je	<addr>
               	movq	%rbx, %rdi
               	shlq	$0x3, %rdi
               	addq	%r12, %rdi
               	movq	(%rdi), %rdi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r8
               	xorq	%rdi, %rdi
               	leaq	<rip>, %rsi
               	movq	%rsi, (%r8)
               	leaq	-0x18(%rbp), %rdx
               	addq	$0x8, %rdx
               	leaq	<rip>, %rsi
               	movq	%rsi, (%rdx)
               	leaq	-0x18(%rbp), %r8
               	addq	$0x10, %r8
               	leaq	<rip>, %rsi
               	movq	%rsi, (%r8)
               	leaq	-0x18(%rbp), %rdx
               	movq	%rbx, %rsi
               	shlq	$0x3, %rsi
               	addq	%rsi, %rdx
               	movq	(%rdx), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	movq	%rbx, %rsi
               	shlq	$0x3, %rsi
               	addq	%r12, %rsi
               	movq	(%rax), %rax
               	movq	%rax, (%rsi)
               	jmp	<addr>
               	shlq	$0x3, %rbx
               	addq	%rbx, %r12
               	movq	(%r12), %r12
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movq	%rdi, %r11
               	movslq	%esi, %r9
               	shlq	$0x2, %r9
               	addq	%r9, %r11
               	movzwq	(%r11), %r9
               	addq	$0x2, %r11
               	movzwq	(%r11), %r11
               	addq	%r11, %r9
               	movslq	%r9d, %rax
               	retq
               	movq	%rdi, %r11
               	movslq	%esi, %r9
               	movl	$0xc, %r10d
               	imulq	%r10, %r9
               	addq	%r9, %r11
               	movslq	(%r11), %r9
               	movq	%r11, %r8
               	addq	$0x4, %r8
               	movslq	(%r8), %r8
               	addq	%r8, %r9
               	movslq	%r9d, %r9
               	addq	$0x8, %r11
               	movslq	(%r11), %r11
               	addq	%r11, %r9
               	movslq	%r9d, %rax
               	retq
               	movq	%rdi, %r11
               	movslq	%esi, %r9
               	shlq	$0x2, %r9
               	addq	%r9, %r11
               	movzbq	(%r11), %r9
               	movq	%r11, %r8
               	addq	$0x1, %r8
               	movzbq	(%r8), %r8
               	addq	%r8, %r9
               	movslq	%r9d, %r9
               	movq	%r11, %r8
               	addq	$0x2, %r8
               	movzbq	(%r8), %r8
               	addq	%r8, %r9
               	movslq	%r9d, %r9
               	addq	$0x3, %r11
               	movzbq	(%r11), %r11
               	addq	%r11, %r9
               	movslq	%r9d, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x4c0, %rsp            # imm = 0x4C0
               	xorq	%r11, %r11
               	movl	%r11d, -0x408(%rbp)
               	jmp	<addr>
               	movslq	-0x408(%rbp), %r11
               	cmpq	$0x100, %r11            # imm = 0x100
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x408(%rbp), %r9
               	movslq	(%r9), %r11
               	addq	$0x1, %r11
               	movl	%r11d, (%r9)
               	jmp	<addr>
               	leaq	-0x400(%rbp), %r11
               	movslq	-0x408(%rbp), %r8
               	shlq	$0x2, %r8
               	addq	%r8, %r11
               	xorq	%r8, %r8
               	movw	%r8w, (%r11)
               	leaq	-0x400(%rbp), %r9
               	movslq	-0x408(%rbp), %r11
               	shlq	$0x2, %r11
               	addq	%r11, %r9
               	addq	$0x2, %r9
               	movw	%r8w, (%r9)
               	jmp	<addr>
               	leaq	-0x400(%rbp), %r9
               	addq	$0x14, %r9
               	movl	$0x1234, %r11d          # imm = 0x1234
               	movw	%r11w, (%r9)
               	leaq	-0x400(%rbp), %r8
               	addq	$0x16, %r8
               	movl	$0x10, %r11d
               	movw	%r11w, (%r8)
               	leaq	-0x400(%rbp), %r9
               	movl	$0x5, %r11d
               	shlq	$0x2, %r11
               	addq	%r11, %r9
               	movzwq	(%r9), %r11
               	addq	$0x2, %r9
               	movzwq	(%r9), %r9
               	addq	%r9, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x1244, %r11           # imm = 0x1244
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x4c0, %rsp            # imm = 0x4C0
               	popq	%rbp
               	retq
               	xorq	%r11, %r11
               	movl	%r11d, -0x408(%rbp)
               	jmp	<addr>
               	movslq	-0x408(%rbp), %r11
               	cmpq	$0xa, %r11
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x408(%rbp), %rax
               	movslq	(%rax), %r11
               	addq	$0x1, %r11
               	movl	%r11d, (%rax)
               	jmp	<addr>
               	xorq	%r11, %r11
               	movl	%r11d, -0x488(%rbp)
               	jmp	<addr>
               	leaq	-0x480(%rbp), %r11
               	movl	$0x7, %r8d
               	movl	$0xc, %r10d
               	imulq	%r10, %r8
               	addq	%r8, %r11
               	movslq	(%r11), %r8
               	movq	%r11, %rax
               	addq	$0x4, %rax
               	movslq	(%rax), %rax
               	addq	%rax, %r8
               	movslq	%r8d, %r8
               	addq	$0x8, %r11
               	movslq	(%r11), %r11
               	addq	%r11, %r8
               	movslq	%r8d, %r8
               	cmpq	$0x837, %r8             # imm = 0x837
               	je	<addr>
               	jmp	<addr>
               	movslq	-0x488(%rbp), %r11
               	cmpq	$0x3, %r11
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x488(%rbp), %r8
               	movslq	(%r8), %r11
               	addq	$0x1, %r11
               	movl	%r11d, (%r8)
               	jmp	<addr>
               	leaq	-0x480(%rbp), %r11
               	movslq	-0x408(%rbp), %rax
               	movl	$0xc, %r8d
               	imulq	%rax, %r8
               	addq	%r8, %r11
               	movslq	-0x488(%rbp), %r8
               	movq	%r8, %rdi
               	shlq	$0x2, %rdi
               	addq	%rdi, %r11
               	movl	$0x64, %r10d
               	imulq	%r10, %rax
               	movslq	%eax, %rax
               	addq	%r8, %rax
               	movslq	%eax, %rax
               	movl	%eax, (%r11)
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0x2, %eax
               	addq	$0x4c0, %rsp            # imm = 0x4C0
               	popq	%rbp
               	retq
               	xorq	%r8, %r8
               	movl	%r8d, -0x408(%rbp)
               	jmp	<addr>
               	movslq	-0x408(%rbp), %r8
               	cmpq	$0x8, %r8
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x408(%rbp), %rax
               	movslq	(%rax), %r8
               	addq	$0x1, %r8
               	movl	%r8d, (%rax)
               	jmp	<addr>
               	xorq	%r8, %r8
               	movl	%r8d, -0x488(%rbp)
               	jmp	<addr>
               	leaq	-0x4a8(%rbp), %r8
               	movl	$0x3, %r11d
               	shlq	$0x2, %r11
               	addq	%r11, %r8
               	movzbq	(%r8), %r11
               	movq	%r8, %rax
               	addq	$0x1, %rax
               	movzbq	(%rax), %rax
               	addq	%rax, %r11
               	movslq	%r11d, %r11
               	movq	%r8, %rax
               	addq	$0x2, %rax
               	movzbq	(%rax), %rax
               	addq	%rax, %r11
               	movslq	%r11d, %r11
               	addq	$0x3, %r8
               	movzbq	(%r8), %r8
               	addq	%r8, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x116, %r11            # imm = 0x116
               	je	<addr>
               	jmp	<addr>
               	movslq	-0x488(%rbp), %r8
               	cmpq	$0x4, %r8
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x488(%rbp), %r11
               	movslq	(%r11), %r8
               	addq	$0x1, %r8
               	movl	%r8d, (%r11)
               	jmp	<addr>
               	leaq	-0x4a8(%rbp), %r8
               	movslq	-0x408(%rbp), %rax
               	movq	%rax, %r11
               	shlq	$0x2, %r11
               	addq	%r11, %r8
               	movslq	-0x488(%rbp), %r11
               	addq	%r11, %r8
               	addq	$0x41, %rax
               	movslq	%eax, %rax
               	addq	%r11, %rax
               	movslq	%eax, %rax
               	andq	$0xff, %rax
               	movb	%al, (%r8)
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0x3, %eax
               	addq	$0x4c0, %rsp            # imm = 0x4C0
               	popq	%rbp
               	retq
               	xorq	%r11, %r11
               	movq	%r11, %rax
               	addq	$0x4c0, %rsp            # imm = 0x4C0
               	popq	%rbp
               	retq
