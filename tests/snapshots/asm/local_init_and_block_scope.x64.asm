
local_init_and_block_scope.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	movslq	%edi, %rdi
               	movslq	%esi, %rsi
               	movslq	%edx, %rdx
               	addq	%rsi, %rdi
               	movslq	%edi, %rdi
               	addq	%rdx, %rdi
               	movslq	%edi, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x70, %rsp
               	xorq	%r11, %r11
               	movl	$0x41, %r9d
               	leaq	<rip>, %r8
               	movl	$0x1, %edi
               	movl	%edi, -0x20(%rbp)
               	movl	$0x3, %esi
               	movl	$0x2, %edi
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	xorq	$0x41, %r9
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r9
               	cmpq	$0x0, %r9
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movzbq	(%r8), %r9
               	xorq	$0x68, %r9
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r9
               	cmpq	$0x0, %r9
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	addq	$0x1, %r8
               	movzbq	(%r8), %r8
               	xorq	$0x69, %r8
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r8
               	cmpq	$0x0, %r8
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movslq	-0x20(%rbp), %r8
               	addq	%rdi, %r8
               	movslq	%r8d, %r8
               	addq	%rsi, %r8
               	movslq	%r8d, %r8
               	cmpq	$0x6, %r8
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movslq	-0x20(%rbp), %r8
               	addq	%rdi, %r8
               	movslq	%r8d, %r8
               	addq	%rsi, %r8
               	movslq	%r8d, %r8
               	movslq	%r8d, %rsi
               	cmpq	$0x6, %rsi
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movslq	%r8d, %rsi
               	shlq	$0x1, %rsi
               	movslq	%esi, %rsi
               	movslq	%esi, %rsi
               	cmpq	$0xc, %rsi
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movl	$0xa, %esi
               	movl	$0x14, %eax
               	movl	$0x1e, %edi
               	addq	%rax, %rsi
               	movslq	%esi, %rsi
               	addq	%rdi, %rsi
               	movslq	%esi, %rsi
               	movslq	%esi, %rsi
               	cmpq	$0x3c, %rsi
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movl	$0x63, %esi
               	cmpq	$0x63, %rsi
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movl	$0x7, %esi
               	cmpq	$0x7, %rsi
               	je	<addr>
               	movl	$0xa, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movslq	%r8d, %r8
               	cmpq	$0x6, %r8
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %r8
               	movslq	(%r8), %r8
               	cmpq	$0x1, %r8
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x60(%rbp), %r8
               	xorq	%rax, %rax
               	movl	%eax, (%r8)
               	leaq	-0x60(%rbp), %rsi
               	addq	$0x4, %rsi
               	movl	%eax, (%rsi)
               	leaq	-0x60(%rbp), %r8
               	leaq	-0x68(%rbp), %rsi
               	pushq	%rax
               	movq	(%r8), %rax
               	movq	%rax, (%rsi)
               	popq	%rax
               	leaq	-0x68(%rbp), %rsi
               	movslq	(%rsi), %rsi
               	cmpq	$0x0, %rsi
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x68(%rbp), %rsi
               	addq	$0x4, %rsi
               	movslq	(%rsi), %rsi
               	cmpq	$0x0, %rsi
               	je	<addr>
               	movl	$0xe, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	xorq	%rsi, %rsi
               	movq	%rsi, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
