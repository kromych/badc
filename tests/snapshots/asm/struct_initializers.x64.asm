
struct_initializers.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	movslq	%edi, %r11
               	movslq	%esi, %r9
               	addq	%r9, %r11
               	movslq	%r11d, %rax
               	retq
               	movslq	%edi, %r11
               	movslq	%esi, %r9
               	subq	%r9, %r11
               	movslq	%r11d, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	<rip>, %r11
               	movslq	(%r11), %r11
               	cmpq	$0x1, %r11
               	je	<addr>
               	movl	$0x1, %r9d
               	movq	%r9, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %r11
               	addq	$0x8, %r11
               	movq	(%r11), %r11
               	movl	$0x2, %edi
               	movl	$0x3, %esi
               	callq	*%r11
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x2, %esi
               	movq	%rsi, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	addq	$0x10, %rax
               	movq	(%rax), %rax
               	movl	$0xa, %edi
               	movl	$0x4, %esi
               	movq	%rax, %r11
               	callq	*%r11
               	movq	%rax, %r11
               	cmpq	$0x6, %r11
               	je	<addr>
               	movl	$0x3, %esi
               	movq	%rsi, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %r11
               	addq	$0x18, %r11
               	movq	(%r11), %r11
               	movzbq	(%r11), %r11
               	xorq	$0x64, %r11
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0x4, %esi
               	movq	%rsi, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %r11
               	movslq	(%r11), %r11
               	cmpq	$0x2, %r11
               	je	<addr>
               	movl	$0x5, %esi
               	movq	%rsi, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %r11
               	addq	$0x8, %r11
               	movq	(%r11), %r11
               	movl	$0x7, %edi
               	movl	$0x8, %esi
               	callq	*%r11
               	cmpq	$0xf, %rax
               	je	<addr>
               	movl	$0x6, %esi
               	movq	%rsi, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	addq	$0x18, %rax
               	movq	(%rax), %rax
               	movzbq	(%rax), %rax
               	xorq	$0x61, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x7, %esi
               	movq	%rsi, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0x8, %esi
               	movq	%rsi, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	addq	$0x8, %rax
               	movq	(%rax), %rax
               	movl	$0x1, %edi
               	movq	%rax, %r11
               	movq	%rdi, %rsi
               	callq	*%r11
               	movq	%rax, %rsi
               	cmpq	$0x2, %rsi
               	je	<addr>
               	movl	$0x9, %edi
               	movq	%rdi, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rsi
               	addq	$0x10, %rsi
               	movq	(%rsi), %rsi
               	movl	$0x5, %edi
               	movl	$0x1, %eax
               	movq	%rsi, %r11
               	movq	%rax, %rsi
               	callq	*%r11
               	movq	%rax, %r11
               	cmpq	$0x4, %r11
               	je	<addr>
               	movl	$0xa, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %r11
               	movslq	(%r11), %r11
               	cmpq	$0xa, %r11
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %r11
               	addq	$0x4, %r11
               	movslq	(%r11), %r11
               	cmpq	$0x14, %r11
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %r11
               	movslq	(%r11), %r11
               	cmpq	$0x1, %r11
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %r11
               	addq	$0x4, %r11
               	movslq	(%r11), %r11
               	cmpq	$0x2, %r11
               	je	<addr>
               	movl	$0xe, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%r11, %r11
               	movq	%r11, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
