
static_locals.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	leaq	<rip>, %r11
               	movslq	(%r11), %r9
               	addq	$0x1, %r9
               	movslq	%r9d, %r9
               	movl	%r9d, (%r11)
               	movslq	(%r11), %rax
               	retq
               	movslq	%edi, %rdi
               	cmpq	$0x0, %rdi
               	je	<addr>
               	leaq	<rip>, %r9
               	movl	$0x64, %edi
               	movl	%edi, (%r9)
               	leaq	<rip>, %r8
               	xorq	%rdi, %rdi
               	movl	%edi, (%r8)
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movslq	(%rdi), %r9
               	addq	$0x1, %r9
               	movslq	%r9d, %r9
               	movl	%r9d, (%rdi)
               	leaq	<rip>, %r8
               	movslq	(%r8), %r9
               	movslq	(%rdi), %r11
               	addq	%r11, %r9
               	movslq	%r9d, %r9
               	movl	%r9d, (%r8)
               	movslq	(%rdi), %rdi
               	movslq	(%r8), %r8
               	addq	%r8, %rdi
               	movslq	%edi, %rax
               	retq
               	leaq	<rip>, %r11
               	movslq	(%r11), %r9
               	addq	$0x1, %r9
               	movslq	%r9d, %r9
               	movl	%r9d, (%r11)
               	movslq	(%r11), %rax
               	retq
               	leaq	<rip>, %r11
               	movslq	(%r11), %r9
               	addq	$0x1, %r9
               	movslq	%r9d, %r9
               	movl	%r9d, (%r11)
               	movslq	(%r11), %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	callq	<addr>
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x1, %r9d
               	movq	%r9, %rax
               	popq	%rbp
               	retq
               	callq	<addr>
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x2, %r9d
               	movq	%r9, %rax
               	popq	%rbp
               	retq
               	callq	<addr>
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0x3, %r9d
               	movq	%r9, %rax
               	popq	%rbp
               	retq
               	xorq	%rdi, %rdi
               	callq	<addr>
               	cmpq	$0xca, %rax
               	je	<addr>
               	movl	$0x4, %edi
               	movq	%rdi, %rax
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rdi
               	callq	<addr>
               	movq	%rax, %rdi
               	cmpq	$0x131, %rdi            # imm = 0x131
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbp
               	retq
               	movl	$0x1, %edi
               	callq	<addr>
               	cmpq	$0xca, %rax
               	je	<addr>
               	movl	$0x6, %edi
               	movq	%rdi, %rax
               	popq	%rbp
               	retq
               	callq	<addr>
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x7, %edi
               	movq	%rdi, %rax
               	popq	%rbp
               	retq
               	callq	<addr>
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x8, %edi
               	movq	%rdi, %rax
               	popq	%rbp
               	retq
               	callq	<addr>
               	cmpq	$0x3e9, %rax            # imm = 0x3E9
               	je	<addr>
               	movl	$0x9, %edi
               	movq	%rdi, %rax
               	popq	%rbp
               	retq
               	callq	<addr>
               	cmpq	$0x3ea, %rax            # imm = 0x3EA
               	je	<addr>
               	movl	$0xa, %edi
               	movq	%rdi, %rax
               	popq	%rbp
               	retq
               	callq	<addr>
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0xb, %edi
               	movq	%rdi, %rax
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
