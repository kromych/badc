
basename_dirname_split.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	leaq	-0x48(%rbp), %rax
               	movb	$0x0, (%rax)
               	leaq	<rip>, %rsi
               	leaq	-0x40(%rbp), %rdi
               	callq	<addr>
               	leaq	-0x40(%rbp), %rdi
               	movq	<rip>, %rax # <addr>
               	callq	*%rax
               	movq	%rax, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	xorl	%eax, %eax
               	shlq	%rax
               	incq	%rax
               	leave
               	retq
               	leaq	<rip>, %rsi
               	leaq	-0x40(%rbp), %rdi
               	callq	<addr>
               	leaq	-0x40(%rbp), %rdi
               	movq	<rip>, %rax # <addr>
               	callq	*%rax
               	movq	%rax, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	xorl	%eax, %eax
               	shlq	%rax
               	addq	$0x2, %rax
               	leave
               	retq
               	leaq	<rip>, %rsi
               	leaq	-0x40(%rbp), %rdi
               	callq	<addr>
               	leaq	-0x40(%rbp), %rdi
               	movq	<rip>, %rax # <addr>
               	callq	*%rax
               	movq	%rax, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	leaq	-0x40(%rbp), %rdi
               	callq	<addr>
               	leaq	-0x40(%rbp), %rdi
               	movq	<rip>, %rax # <addr>
               	callq	*%rax
               	movq	%rax, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	leaq	-0x40(%rbp), %rdi
               	callq	<addr>
               	leaq	-0x40(%rbp), %rdi
               	movq	<rip>, %rax # <addr>
               	callq	*%rax
               	movq	%rax, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	leaq	-0x40(%rbp), %rdi
               	callq	<addr>
               	leaq	-0x40(%rbp), %rdi
               	movq	<rip>, %rax # <addr>
               	callq	*%rax
               	movq	%rax, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	leaq	-0x40(%rbp), %rdi
               	callq	<addr>
               	leaq	-0x40(%rbp), %rdi
               	movq	<rip>, %rax # <addr>
               	callq	*%rax
               	movq	%rax, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	leaq	-0x40(%rbp), %rdi
               	callq	<addr>
               	leaq	-0x40(%rbp), %rdi
               	movq	<rip>, %rax # <addr>
               	callq	*%rax
               	movq	%rax, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	leaq	-0x40(%rbp), %rdi
               	callq	<addr>
               	leaq	-0x40(%rbp), %rdi
               	movq	<rip>, %rax # <addr>
               	callq	*%rax
               	movq	%rax, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	leaq	-0x40(%rbp), %rdi
               	callq	<addr>
               	leaq	-0x40(%rbp), %rdi
               	movq	<rip>, %rax # <addr>
               	callq	*%rax
               	movq	%rax, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	leaq	-0x40(%rbp), %rdi
               	callq	<addr>
               	leaq	-0x40(%rbp), %rdi
               	movq	<rip>, %rax # <addr>
               	callq	*%rax
               	movq	%rax, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	leaq	-0x40(%rbp), %rdi
               	callq	<addr>
               	leaq	-0x40(%rbp), %rdi
               	movq	<rip>, %rax # <addr>
               	callq	*%rax
               	movq	%rax, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	leaq	-0x40(%rbp), %rdi
               	callq	<addr>
               	leaq	-0x40(%rbp), %rdi
               	movq	<rip>, %rax # <addr>
               	callq	*%rax
               	movq	%rax, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	leaq	-0x40(%rbp), %rdi
               	callq	<addr>
               	leaq	-0x40(%rbp), %rdi
               	movq	<rip>, %rax # <addr>
               	callq	*%rax
               	movq	%rax, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	leaq	-0x40(%rbp), %rdi
               	callq	<addr>
               	leaq	-0x40(%rbp), %rdi
               	movq	<rip>, %rax # <addr>
               	callq	*%rax
               	movq	%rax, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	leaq	-0x40(%rbp), %rdi
               	callq	<addr>
               	leaq	-0x40(%rbp), %rdi
               	movq	<rip>, %rax # <addr>
               	callq	*%rax
               	movq	%rax, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	jmp	<addr>
               	leaq	-0x48(%rbp), %rdi
               	callq	<addr>
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	xorl	%edi, %edi
               	callq	<addr>
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x64, %eax
               	leave
               	retq
               	xorl	%edi, %edi
               	callq	<addr>
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x65, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
               	movl	$0x7, %eax
               	jmp	<addr>
               	movl	$0x7, %eax
               	jmp	<addr>
               	movl	$0x6, %eax
               	jmp	<addr>
               	movl	$0x6, %eax
               	jmp	<addr>
               	movl	$0x5, %eax
               	jmp	<addr>
               	movl	$0x5, %eax
               	jmp	<addr>
               	movl	$0x4, %eax
               	jmp	<addr>
               	movl	$0x4, %eax
               	jmp	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
