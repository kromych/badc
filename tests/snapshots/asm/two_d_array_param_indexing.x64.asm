
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
               	movq	%rdi, %rbx
               	movslq	%ebx, %rbx
               	leaq	<rip>, %r12
               	movq	%rbx, %rax
               	shlq	$0x3, %rax
               	addq	%r12, %rax
               	movq	(%rax), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movq	%rbx, %rax
               	shlq	$0x3, %rax
               	addq	%r12, %rax
               	movq	(%rax), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	xorq	%rdi, %rdi
               	leaq	<rip>, %rcx
               	movq	%rcx, (%rax)
               	leaq	-0x18(%rbp), %rax
               	addq	$0x8, %rax
               	leaq	<rip>, %rcx
               	movq	%rcx, (%rax)
               	leaq	-0x18(%rbp), %rax
               	addq	$0x10, %rax
               	leaq	<rip>, %rcx
               	movq	%rcx, (%rax)
               	leaq	-0x18(%rbp), %rax
               	movq	%rbx, %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %rax
               	movq	(%rax), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	movq	%rbx, %rcx
               	shlq	$0x3, %rcx
               	addq	%r12, %rcx
               	movq	(%rax), %rax
               	movq	%rax, (%rcx)
               	jmp	<addr>
               	movq	%rbx, %rax
               	shlq	$0x3, %rax
               	addq	%r12, %rax
               	movq	(%rax), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movq	%rdi, %rax
               	movq	%rsi, %rcx
               	movslq	%ecx, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rax
               	movzwq	(%rax), %rcx
               	addq	$0x2, %rax
               	movzwq	(%rax), %rax
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	retq
               	movq	%rdi, %rax
               	movq	%rsi, %rcx
               	movslq	%ecx, %rcx
               	movl	$0xc, %r11d
               	imulq	%r11, %rcx
               	addq	%rcx, %rax
               	movslq	(%rax), %rcx
               	movq	%rax, %rdx
               	addq	$0x4, %rdx
               	movslq	(%rdx), %rdx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	addq	$0x8, %rax
               	movslq	(%rax), %rax
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	retq
               	movq	%rdi, %rax
               	movq	%rsi, %rcx
               	movslq	%ecx, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rax
               	movzbq	(%rax), %rcx
               	movq	%rax, %rdx
               	addq	$0x1, %rdx
               	movzbq	(%rdx), %rdx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	movq	%rax, %rdx
               	addq	$0x2, %rdx
               	movzbq	(%rdx), %rdx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	addq	$0x3, %rax
               	movzbq	(%rax), %rax
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x4c0, %rsp            # imm = 0x4C0
               	xorq	%rax, %rax
               	movl	%eax, -0x408(%rbp)
               	jmp	<addr>
               	movslq	-0x408(%rbp), %rax
               	cmpq	$0x100, %rax            # imm = 0x100
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x408(%rbp), %rax
               	movslq	(%rax), %rcx
               	addq	$0x1, %rcx
               	movl	%ecx, (%rax)
               	jmp	<addr>
               	leaq	-0x400(%rbp), %rax
               	movslq	-0x408(%rbp), %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rax
               	xorq	%rcx, %rcx
               	movw	%cx, (%rax)
               	leaq	-0x400(%rbp), %rax
               	movslq	-0x408(%rbp), %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %rax
               	addq	$0x2, %rax
               	movw	%cx, (%rax)
               	jmp	<addr>
               	leaq	-0x400(%rbp), %rax
               	addq	$0x14, %rax
               	movl	$0x1234, %ecx           # imm = 0x1234
               	movw	%cx, (%rax)
               	leaq	-0x400(%rbp), %rax
               	addq	$0x16, %rax
               	movl	$0x10, %ecx
               	movw	%cx, (%rax)
               	leaq	-0x400(%rbp), %rax
               	movl	$0x5, %ecx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rax
               	movzwq	(%rax), %rcx
               	addq	$0x2, %rax
               	movzwq	(%rax), %rax
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	cmpq	$0x1244, %rax           # imm = 0x1244
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x4c0, %rsp            # imm = 0x4C0
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movl	%eax, -0x408(%rbp)
               	jmp	<addr>
               	movslq	-0x408(%rbp), %rax
               	cmpq	$0xa, %rax
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x408(%rbp), %rax
               	movslq	(%rax), %rcx
               	addq	$0x1, %rcx
               	movl	%ecx, (%rax)
               	jmp	<addr>
               	xorq	%rax, %rax
               	movl	%eax, -0x488(%rbp)
               	jmp	<addr>
               	leaq	-0x480(%rbp), %rax
               	movl	$0x7, %ecx
               	movl	$0xc, %r11d
               	imulq	%r11, %rcx
               	addq	%rcx, %rax
               	movslq	(%rax), %rcx
               	movq	%rax, %rdx
               	addq	$0x4, %rdx
               	movslq	(%rdx), %rdx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	addq	$0x8, %rax
               	movslq	(%rax), %rax
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	cmpq	$0x837, %rax            # imm = 0x837
               	je	<addr>
               	jmp	<addr>
               	movslq	-0x488(%rbp), %rax
               	cmpq	$0x3, %rax
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x488(%rbp), %rax
               	movslq	(%rax), %rcx
               	addq	$0x1, %rcx
               	movl	%ecx, (%rax)
               	jmp	<addr>
               	leaq	-0x480(%rbp), %rax
               	movslq	-0x408(%rbp), %rcx
               	movl	$0xc, %edx
               	imulq	%rcx, %rdx
               	addq	%rdx, %rax
               	movslq	-0x488(%rbp), %rdx
               	movq	%rdx, %rsi
               	shlq	$0x2, %rsi
               	addq	%rsi, %rax
               	movl	$0x64, %r11d
               	imulq	%r11, %rcx
               	movslq	%ecx, %rcx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	movl	%ecx, (%rax)
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0x2, %eax
               	addq	$0x4c0, %rsp            # imm = 0x4C0
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movl	%eax, -0x408(%rbp)
               	jmp	<addr>
               	movslq	-0x408(%rbp), %rax
               	cmpq	$0x8, %rax
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x408(%rbp), %rax
               	movslq	(%rax), %rcx
               	addq	$0x1, %rcx
               	movl	%ecx, (%rax)
               	jmp	<addr>
               	xorq	%rax, %rax
               	movl	%eax, -0x488(%rbp)
               	jmp	<addr>
               	leaq	-0x4a8(%rbp), %rax
               	movl	$0x3, %ecx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rax
               	movzbq	(%rax), %rcx
               	movq	%rax, %rdx
               	addq	$0x1, %rdx
               	movzbq	(%rdx), %rdx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	movq	%rax, %rdx
               	addq	$0x2, %rdx
               	movzbq	(%rdx), %rdx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	addq	$0x3, %rax
               	movzbq	(%rax), %rax
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	cmpq	$0x116, %rax            # imm = 0x116
               	je	<addr>
               	jmp	<addr>
               	movslq	-0x488(%rbp), %rax
               	cmpq	$0x4, %rax
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x488(%rbp), %rax
               	movslq	(%rax), %rcx
               	addq	$0x1, %rcx
               	movl	%ecx, (%rax)
               	jmp	<addr>
               	leaq	-0x4a8(%rbp), %rax
               	movslq	-0x408(%rbp), %rcx
               	movq	%rcx, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %rax
               	movslq	-0x488(%rbp), %rdx
               	addq	%rdx, %rax
               	addq	$0x41, %rcx
               	movslq	%ecx, %rcx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, (%rax)
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0x3, %eax
               	addq	$0x4c0, %rsp            # imm = 0x4C0
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x4c0, %rsp            # imm = 0x4C0
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
