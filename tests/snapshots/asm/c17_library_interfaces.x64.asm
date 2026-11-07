
c17_library_interfaces.x64:	file format elf64-x86-64

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

<h1>:
               	leaq	<rip>, %rcx # <addr>
               	movslq	<rip>, %rax # <addr>
               	leaq	0x1(%rax), %rdx
               	movl	%edx, <rip> # <addr>
               	movl	$0x1, (%rcx,%rax,4)
               	retq

<h2>:
               	leaq	<rip>, %rcx # <addr>
               	movslq	<rip>, %rax # <addr>
               	leaq	0x1(%rax), %rdx
               	movl	%edx, <rip> # <addr>
               	movl	$0x2, (%rcx,%rax,4)
               	retq

<last>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x2, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x2, %eax
               	jne	<addr>
               	xorl	%edi, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	ud2
               	movl	$0x14, %edi
               	jmp	<addr>

<ascii>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xa0, %rsp
               	leaq	-0x80(%rbp), %rdi
               	xorl	%esi, %esi
               	movl	$0x80, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0xa0(%rbp), %rdi
               	leaq	<rip>, %rsi
               	movl	$0x1, %edx
               	leaq	-0x80(%rbp), %rcx
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x1, %rax
               	jne	<addr>
               	movzwq	-0xa0(%rbp), %rax
               	xorq	$0x41, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x1e, %eax
               	leave
               	retq
               	leaq	-0x98(%rbp), %rdi
               	leaq	<rip>, %rsi
               	movl	$0x1, %edx
               	leaq	-0x80(%rbp), %rcx
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x1, %rax
               	jne	<addr>
               	movl	-0x98(%rbp), %eax
               	xorq	$0x7a, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x1f, %eax
               	leave
               	retq
               	leaq	-0x90(%rbp), %rdi
               	movl	$0x71, %esi
               	leaq	-0x80(%rbp), %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x1, %rax
               	jne	<addr>
               	leaq	-0x90(%rbp), %rdi
               	movsbq	-0x90(%rbp), %rax
               	cmpl	$0x71, %eax
               	je	<addr>
               	movl	$0x20, %eax
               	leave
               	retq
               	movl	$0x72, %esi
               	leaq	-0x80(%rbp), %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x1, %rax
               	jne	<addr>
               	movsbq	-0x90(%rbp), %rax
               	cmpl	$0x72, %eax
               	je	<addr>
               	movl	$0x21, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq

<utf8>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xb0, %rsp
               	xorl	%edi, %edi
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	xorl	%edi, %edi
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	xorl	%eax, %eax
               	leave
               	retq
               	leaq	-0x80(%rbp), %rdi
               	xorl	%esi, %esi
               	movl	$0x80, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0xb0(%rbp), %rdi
               	movl	$0x1, %edx
               	leaq	-0x80(%rbp), %rcx
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x1, %rax
               	jne	<addr>
               	movl	-0xb0(%rbp), %eax
               	xorq	$0x61, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	-0xb0(%rbp), %rdi
               	leaq	<rip>, %rax
               	leaq	0x1(%rax), %rsi
               	movl	$0x1, %edx
               	leaq	-0x80(%rbp), %rcx
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$-0x2, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	leaq	-0xb0(%rbp), %rdi
               	leaq	<rip>, %rax
               	leaq	0x2(%rax), %rsi
               	movl	$0x5, %edx
               	leaq	-0x80(%rbp), %rcx
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x1, %rax
               	jne	<addr>
               	movl	-0xb0(%rbp), %eax
               	xorq	$0xe9, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	leaq	-0xb0(%rbp), %rdi
               	leaq	<rip>, %rax
               	leaq	0x3(%rax), %rsi
               	movl	$0x4, %edx
               	leaq	-0x80(%rbp), %rcx
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x4, %rax
               	jne	<addr>
               	movl	-0xb0(%rbp), %eax
               	xorq	$0x1f600, %rax          # imm = 0x1F600
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	leaq	-0x80(%rbp), %rdi
               	xorl	%esi, %esi
               	movl	$0x80, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0xa8(%rbp), %rdi
               	leaq	<rip>, %rax
               	leaq	0x3(%rax), %rsi
               	movl	$0x4, %edx
               	leaq	-0x80(%rbp), %rcx
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x4, %rax
               	jne	<addr>
               	leaq	-0xa8(%rbp), %rax
               	movzwq	-0xa8(%rbp), %rcx
               	xorq	$0xd83d, %rcx           # imm = 0xD83D
               	testl	%ecx, %ecx
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	leaq	0x2(%rax), %rdi
               	leaq	<rip>, %rax
               	leaq	0x7(%rax), %rsi
               	xorl	%edx, %edx
               	leaq	-0x80(%rbp), %rcx
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$-0x3, %rax
               	jne	<addr>
               	movzwq	-0xa6(%rbp), %rax
               	xorq	$0xde00, %rax           # imm = 0xDE00
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	leaq	-0x80(%rbp), %rdi
               	xorl	%esi, %esi
               	movl	$0x80, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0xa0(%rbp), %rdi
               	movzwq	-0xa8(%rbp), %rsi
               	leaq	-0x80(%rbp), %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	leaq	-0xa0(%rbp), %rdi
               	movzwq	-0xa6(%rbp), %rsi
               	leaq	-0x80(%rbp), %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x4, %rax
               	jne	<addr>
               	leaq	-0xa0(%rbp), %rdi
               	leaq	<rip>, %rax
               	leaq	0x3(%rax), %rsi
               	movl	$0x4, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	leaq	-0xa0(%rbp), %rdi
               	movl	$0xe9, %esi
               	leaq	-0x80(%rbp), %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x2, %rax
               	jne	<addr>
               	leaq	-0xa0(%rbp), %rdi
               	leaq	<rip>, %rax
               	leaq	0x1(%rax), %rsi
               	movl	$0x2, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	leaq	-0xa0(%rbp), %rdi
               	movl	$0xd800, %esi           # imm = 0xD800
               	leaq	-0x80(%rbp), %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	leaq	-0xa0(%rbp), %rdi
               	movl	$0xdc00, %esi           # imm = 0xDC00
               	leaq	-0x80(%rbp), %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	leave
               	retq
               	leaq	-0xb0(%rbp), %rdi
               	leaq	<rip>, %rsi
               	movl	$0x1, %edx
               	leaq	-0x80(%rbp), %rcx
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	cmpl	$0x0, -0xb0(%rbp)
               	je	<addr>
               	movl	$0xc, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leave
               	retq
               	leaq	-0x10(%rbp), %rdi
               	movl	$0x1, %esi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x1, %rax
               	jne	<addr>
               	leaq	-0x10(%rbp), %rdi
               	movq	-0x10(%rbp), %rax
               	cmpq	$0x6553f100, %rax       # imm = 0x6553F100
               	jl	<addr>
               	movq	-0x8(%rbp), %rax
               	testq	%rax, %rax
               	jl	<addr>
               	movq	-0x8(%rbp), %rax
               	cmpq	$0x3b9aca00, %rax       # imm = 0x3B9ACA00
               	jl	<addr>
               	movl	$0x28, %eax
               	leave
               	retq
               	xorl	%esi, %esi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x29, %eax
               	leave
               	retq
               	movl	$0x10, %edi
               	movl	$0x40, %esi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	testb	$0xf, %dil
               	je	<addr>
               	movl	$0x2a, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0x40, %edi
               	movl	$0x80, %esi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	testb	$0x3f, %dil
               	je	<addr>
               	movl	$0x2c, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-<rip>, %rdi # <addr>
               	xorl	%esi, %esi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-<rip>, %rdi # <addr>
               	xorl	%esi, %esi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-<rip>, %rdi # <addr>
               	xorl	%esi, %esi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2b, %eax
               	leave
               	retq
               	movl	$0x1e, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	ud2
