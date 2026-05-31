
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
               	subq	$0x4e0, %rsp            # imm = 0x4E0
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
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
               	leaq	-0x400(%rbp), %rbx
               	movl	$0x5, %r12d
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	movl	$0x1244, %r12d          # imm = 0x1244
               	movslq	%r12d, %r12
               	cmpq	%r12, %rax
               	je	<addr>
               	movl	$0x1, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x4e0, %rsp            # imm = 0x4E0
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movl	%eax, -0x408(%rbp)
               	jmp	<addr>
               	movslq	-0x408(%rbp), %rax
               	cmpq	$0xa, %rax
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x408(%rbp), %r12
               	movslq	(%r12), %rax
               	addq	$0x1, %rax
               	movl	%eax, (%r12)
               	jmp	<addr>
               	xorq	%rax, %rax
               	movl	%eax, -0x488(%rbp)
               	jmp	<addr>
               	leaq	-0x480(%rbp), %r14
               	movl	$0x7, %r12d
               	movq	%r14, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	cmpq	$0x837, %rax            # imm = 0x837
               	je	<addr>
               	jmp	<addr>
               	movslq	-0x488(%rbp), %rax
               	cmpq	$0x3, %rax
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x488(%rbp), %rbx
               	movslq	(%rbx), %rax
               	addq	$0x1, %rax
               	movl	%eax, (%rbx)
               	jmp	<addr>
               	leaq	-0x480(%rbp), %rax
               	movslq	-0x408(%rbp), %r12
               	movl	$0xc, %ebx
               	imulq	%r12, %rbx
               	addq	%rbx, %rax
               	movslq	-0x488(%rbp), %rbx
               	movq	%rbx, %rdi
               	shlq	$0x2, %rdi
               	addq	%rdi, %rax
               	movl	$0x64, %r11d
               	imulq	%r11, %r12
               	movslq	%r12d, %r12
               	addq	%rbx, %r12
               	movslq	%r12d, %r12
               	movl	%r12d, (%rax)
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0x2, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x4e0, %rsp            # imm = 0x4E0
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movl	%eax, -0x408(%rbp)
               	jmp	<addr>
               	movslq	-0x408(%rbp), %rax
               	cmpq	$0x8, %rax
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x408(%rbp), %r12
               	movslq	(%r12), %rax
               	addq	$0x1, %rax
               	movl	%eax, (%r12)
               	jmp	<addr>
               	xorq	%rax, %rax
               	movl	%eax, -0x488(%rbp)
               	jmp	<addr>
               	leaq	-0x4a8(%rbp), %rbx
               	movl	$0x3, %r12d
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	cmpq	$0x116, %rax            # imm = 0x116
               	je	<addr>
               	jmp	<addr>
               	movslq	-0x488(%rbp), %rax
               	cmpq	$0x4, %rax
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x488(%rbp), %r14
               	movslq	(%r14), %rax
               	addq	$0x1, %rax
               	movl	%eax, (%r14)
               	jmp	<addr>
               	leaq	-0x4a8(%rbp), %rax
               	movslq	-0x408(%rbp), %r12
               	movq	%r12, %r14
               	shlq	$0x2, %r14
               	addq	%r14, %rax
               	movslq	-0x488(%rbp), %r14
               	addq	%r14, %rax
               	addq	$0x41, %r12
               	movslq	%r12d, %r12
               	addq	%r14, %r12
               	movslq	%r12d, %r12
               	andq	$0xff, %r12
               	movb	%r12b, (%rax)
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0x3, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x4e0, %rsp            # imm = 0x4E0
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x4e0, %rsp            # imm = 0x4E0
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
