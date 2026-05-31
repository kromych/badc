
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
               	movq	%rdi, %r11
               	movslq	%esi, %r9
               	shlq	$0x2, %r9
               	addq	%r9, %r11
               	movzwq	(%r11), %r9
               	addq	$0x2, %r11
               	movzwq	(%r11), %r8
               	addq	%r8, %r9
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
               	movslq	(%r8), %rdi
               	addq	%rdi, %r9
               	movslq	%r9d, %r9
               	addq	$0x8, %r11
               	movslq	(%r11), %rdi
               	addq	%rdi, %r9
               	movslq	%r9d, %rax
               	retq
               	movq	%rdi, %r11
               	movslq	%esi, %r9
               	shlq	$0x2, %r9
               	addq	%r9, %r11
               	movzbq	(%r11), %r9
               	movq	%r11, %r8
               	addq	$0x1, %r8
               	movzbq	(%r8), %rdi
               	addq	%rdi, %r9
               	movslq	%r9d, %r9
               	movq	%r11, %rdi
               	addq	$0x2, %rdi
               	movzbq	(%rdi), %r8
               	addq	%r8, %r9
               	movslq	%r9d, %r9
               	addq	$0x3, %r11
               	movzbq	(%r11), %r8
               	addq	%r8, %r9
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
               	movzwq	(%r9), %r8
               	addq	%r8, %r11
               	movslq	%r11d, %r11
               	movl	$0x1244, %r8d           # imm = 0x1244
               	movslq	%r8d, %r8
               	cmpq	%r8, %r11
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
               	movl	$0x7, %r9d
               	movl	$0xc, %r10d
               	imulq	%r10, %r9
               	addq	%r9, %r11
               	movslq	(%r11), %r9
               	movq	%r11, %rax
               	addq	$0x4, %rax
               	movslq	(%rax), %rdi
               	addq	%rdi, %r9
               	movslq	%r9d, %r9
               	addq	$0x8, %r11
               	movslq	(%r11), %rdi
               	addq	%rdi, %r9
               	movslq	%r9d, %r9
               	cmpq	$0x837, %r9             # imm = 0x837
               	je	<addr>
               	jmp	<addr>
               	movslq	-0x488(%rbp), %rdi
               	cmpq	$0x3, %rdi
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x488(%rbp), %r9
               	movslq	(%r9), %rdi
               	addq	$0x1, %rdi
               	movl	%edi, (%r9)
               	jmp	<addr>
               	leaq	-0x480(%rbp), %rdi
               	movslq	-0x408(%rbp), %r11
               	movl	$0xc, %r9d
               	imulq	%r11, %r9
               	addq	%r9, %rdi
               	movslq	-0x488(%rbp), %r9
               	movq	%r9, %rax
               	shlq	$0x2, %rax
               	addq	%rax, %rdi
               	movl	$0x64, %r10d
               	imulq	%r10, %r11
               	movslq	%r11d, %r11
               	addq	%r9, %r11
               	movslq	%r11d, %r11
               	movl	%r11d, (%rdi)
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0x2, %eax
               	addq	$0x4c0, %rsp            # imm = 0x4C0
               	popq	%rbp
               	retq
               	xorq	%r9, %r9
               	movl	%r9d, -0x408(%rbp)
               	jmp	<addr>
               	movslq	-0x408(%rbp), %r9
               	cmpq	$0x8, %r9
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x408(%rbp), %rax
               	movslq	(%rax), %r9
               	addq	$0x1, %r9
               	movl	%r9d, (%rax)
               	jmp	<addr>
               	xorq	%r9, %r9
               	movl	%r9d, -0x488(%rbp)
               	jmp	<addr>
               	leaq	-0x4a8(%rbp), %r9
               	movl	$0x3, %edi
               	shlq	$0x2, %rdi
               	addq	%rdi, %r9
               	movzbq	(%r9), %rdi
               	movq	%r9, %rax
               	addq	$0x1, %rax
               	movzbq	(%rax), %r11
               	addq	%r11, %rdi
               	movslq	%edi, %rdi
               	movq	%r9, %r11
               	addq	$0x2, %r11
               	movzbq	(%r11), %rax
               	addq	%rax, %rdi
               	movslq	%edi, %rdi
               	addq	$0x3, %r9
               	movzbq	(%r9), %rax
               	addq	%rax, %rdi
               	movslq	%edi, %rdi
               	cmpq	$0x116, %rdi            # imm = 0x116
               	je	<addr>
               	jmp	<addr>
               	movslq	-0x488(%rbp), %rax
               	cmpq	$0x4, %rax
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x488(%rbp), %rdi
               	movslq	(%rdi), %rax
               	addq	$0x1, %rax
               	movl	%eax, (%rdi)
               	jmp	<addr>
               	leaq	-0x4a8(%rbp), %rax
               	movslq	-0x408(%rbp), %r9
               	movq	%r9, %rdi
               	shlq	$0x2, %rdi
               	addq	%rdi, %rax
               	movslq	-0x488(%rbp), %rdi
               	addq	%rdi, %rax
               	addq	$0x41, %r9
               	movslq	%r9d, %r9
               	addq	%rdi, %r9
               	movslq	%r9d, %r9
               	andq	$0xff, %r9
               	movb	%r9b, (%rax)
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0x3, %eax
               	addq	$0x4c0, %rsp            # imm = 0x4C0
               	popq	%rbp
               	retq
               	xorq	%rdi, %rdi
               	movq	%rdi, %rax
               	addq	$0x4c0, %rsp            # imm = 0x4C0
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
