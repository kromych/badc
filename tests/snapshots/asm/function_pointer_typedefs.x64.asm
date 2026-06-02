
function_pointer_typedefs.x64:	file format elf64-x86-64

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
               	movslq	%edi, %r11
               	movslq	%esi, %r9
               	cmpq	%r9, %r11
               	jge	<addr>
               	movabsq	$-0x1, %rax
               	retq
               	cmpq	%r9, %r11
               	jle	<addr>
               	movl	$0x1, %eax
               	retq
               	xorq	%r11, %r11
               	movq	%r11, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movq	%rdi, %r11
               	movslq	%esi, %rdi
               	movslq	%edx, %rsi
               	callq	*%r11
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	movq	%rbx, (%rsp)
               	leaq	-<rip>, %rbx       # <addr>
               	movl	$0x3, %edi
               	movl	$0x5, %esi
               	movq	%rbx, %r11
               	callq	*%r11
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0x1, %edi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movl	$0x7, %eax
               	movl	$0x2, %esi
               	movq	%rbx, %r11
               	movq	%rax, %rdi
               	callq	*%r11
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x2, %esi
               	movq	%rsi, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movl	$0x4, %edi
               	movq	%rbx, %r11
               	movq	%rdi, %rsi
               	callq	*%r11
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x3, %edi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rax
               	leaq	-<rip>, %rdi      # <addr>
               	movq	%rdi, (%rax)
               	leaq	-0x20(%rbp), %rsi
               	addq	$0x8, %rsi
               	leaq	-<rip>, %rdi      # <addr>
               	movq	%rdi, (%rsi)
               	leaq	-0x20(%rbp), %rax
               	addq	$0x10, %rax
               	leaq	-<rip>, %rdi      # <addr>
               	movq	%rdi, (%rax)
               	leaq	-0x20(%rbp), %rsi
               	movq	(%rsi), %rsi
               	movl	$0x2, %edi
               	movl	$0x3, %eax
               	movq	%rsi, %r11
               	movq	%rax, %rsi
               	callq	*%r11
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x4, %esi
               	movq	%rsi, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rax
               	addq	$0x8, %rax
               	movq	(%rax), %rax
               	movl	$0xa, %edi
               	movl	$0x4, %esi
               	movq	%rax, %r11
               	callq	*%r11
               	cmpq	$0x6, %rax
               	je	<addr>
               	movl	$0x5, %esi
               	movq	%rsi, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rax
               	addq	$0x10, %rax
               	movq	(%rax), %rax
               	movl	$0x1, %edi
               	movl	$0x2, %esi
               	movq	%rax, %r11
               	callq	*%r11
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0x6, %esi
               	movq	%rsi, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-<rip>, %rdi      # <addr>
               	movl	$0x8, %esi
               	movl	$0x9, %edx
               	callq	<addr>
               	cmpq	$0x11, %rax
               	je	<addr>
               	movl	$0x7, %esi
               	movq	%rsi, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
