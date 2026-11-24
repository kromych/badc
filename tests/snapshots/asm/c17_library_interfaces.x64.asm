
c17_library_interfaces.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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
               	pushq	%rax
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
               	callq	<addr>
               	ud2
               	movl	$0x14, %edi
               	jmp	<addr>

<main>:
               	subq	$0x48, %rsp
               	leaq	0x8(%rsp), %rcx
               	movq	$0x0, 0x8(%rsp)
               	leaq	0x10(%rsp), %rdi
               	leaq	<rip>, %rsi
               	movl	$0x1, %edx
               	callq	<addr>
               	cmpq	$0x1, %rax
               	jne	<addr>
               	movzwq	0x10(%rsp), %rax
               	cmpl	$0x41, %eax
               	je	<addr>
               	movl	$0x1e, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	xorl	%edi, %edi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	xorl	%edi, %edi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	xorl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	addq	$0x48, %rsp
               	retq
               	leaq	0x30(%rsp), %rdi
               	movl	$0x1, %esi
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x1, %rax
               	jne	<addr>
               	leaq	0x30(%rsp), %rdi
               	movq	0x30(%rsp), %rax
               	cmpq	$0x6553f100, %rax       # imm = 0x6553F100
               	jl	<addr>
               	movq	0x38(%rsp), %rax
               	testq	%rax, %rax
               	jl	<addr>
               	cmpq	$0x3b9aca00, %rax       # imm = 0x3B9ACA00
               	jl	<addr>
               	movl	$0x28, %eax
               	addq	$0x48, %rsp
               	retq
               	xorl	%esi, %esi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x29, %eax
               	addq	$0x48, %rsp
               	retq
               	movl	$0x10, %edi
               	movl	$0x40, %esi
               	callq	<addr>
               	movq	%rax, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	testb	$0xf, %dil
               	je	<addr>
               	movl	$0x2a, %eax
               	addq	$0x48, %rsp
               	retq
               	callq	<addr>
               	movl	$0x40, %edi
               	movl	$0x80, %esi
               	callq	<addr>
               	movq	%rax, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	testb	$0x3f, %dil
               	je	<addr>
               	movl	$0x2c, %eax
               	addq	$0x48, %rsp
               	retq
               	callq	<addr>
               	leaq	-<rip>, %rdi # <addr>
               	xorl	%esi, %esi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-<rip>, %rdi # <addr>
               	xorl	%esi, %esi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-<rip>, %rdi # <addr>
               	xorl	%esi, %esi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2b, %eax
               	addq	$0x48, %rsp
               	retq
               	leaq	<rip>, %rsi
               	leaq	0x8(%rsp), %rcx
               	movq	$0x0, 0x8(%rsp)
               	leaq	0x10(%rsp), %rdi
               	movl	$0x1, %edx
               	callq	<addr>
               	cmpq	$0x1, %rax
               	jne	<addr>
               	movl	0x10(%rsp), %eax
               	cmpl	$0x61, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	leaq	0x10(%rsp), %rdi
               	leaq	<rip>, %rax
               	leaq	0x1(%rax), %rsi
               	movl	$0x1, %edx
               	leaq	0x8(%rsp), %rcx
               	callq	<addr>
               	cmpq	$-0x2, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	leaq	0x10(%rsp), %rdi
               	leaq	<rip>, %rax
               	leaq	0x2(%rax), %rsi
               	movl	$0x5, %edx
               	leaq	0x8(%rsp), %rcx
               	callq	<addr>
               	cmpq	$0x1, %rax
               	jne	<addr>
               	movl	0x10(%rsp), %eax
               	cmpl	$0xe9, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	leaq	0x10(%rsp), %rdi
               	leaq	<rip>, %rax
               	leaq	0x3(%rax), %rsi
               	movl	$0x4, %edx
               	leaq	0x8(%rsp), %rcx
               	callq	<addr>
               	cmpq	$0x4, %rax
               	jne	<addr>
               	movl	0x10(%rsp), %eax
               	cmpl	$0x1f600, %eax          # imm = 0x1F600
               	je	<addr>
               	movl	$0x4, %eax
               	jmp	<addr>
               	leaq	0x8(%rsp), %rcx
               	movq	$0x0, 0x8(%rsp)
               	leaq	0x18(%rsp), %rdi
               	leaq	<rip>, %rax
               	leaq	0x3(%rax), %rsi
               	movl	$0x4, %edx
               	callq	<addr>
               	cmpq	$0x4, %rax
               	jne	<addr>
               	leaq	0x18(%rsp), %rax
               	movzwq	0x18(%rsp), %rcx
               	cmpl	$0xd83d, %ecx           # imm = 0xD83D
               	je	<addr>
               	movl	$0x5, %eax
               	jmp	<addr>
               	leaq	0x2(%rax), %rdi
               	leaq	<rip>, %rax
               	leaq	0x7(%rax), %rsi
               	xorl	%edx, %edx
               	leaq	0x8(%rsp), %rcx
               	callq	<addr>
               	cmpq	$-0x3, %rax
               	jne	<addr>
               	movzwq	0x1a(%rsp), %rax
               	cmpl	$0xde00, %eax           # imm = 0xDE00
               	je	<addr>
               	movl	$0x6, %eax
               	jmp	<addr>
               	leaq	0x8(%rsp), %rdx
               	movq	$0x0, 0x8(%rsp)
               	leaq	0x20(%rsp), %rdi
               	movzwq	0x18(%rsp), %rsi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	jmp	<addr>
               	leaq	0x20(%rsp), %rdi
               	movzwq	0x1a(%rsp), %rsi
               	leaq	0x8(%rsp), %rdx
               	callq	<addr>
               	cmpq	$0x4, %rax
               	jne	<addr>
               	leaq	0x20(%rsp), %rdi
               	leaq	<rip>, %rax
               	leaq	0x3(%rax), %rsi
               	movl	$0x4, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	jmp	<addr>
               	leaq	0x20(%rsp), %rdi
               	movl	$0xe9, %esi
               	leaq	0x8(%rsp), %rdx
               	callq	<addr>
               	cmpq	$0x2, %rax
               	jne	<addr>
               	leaq	0x20(%rsp), %rdi
               	leaq	<rip>, %rax
               	leaq	0x1(%rax), %rsi
               	movl	$0x2, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	jmp	<addr>
               	leaq	0x20(%rsp), %rdi
               	movl	$0xd800, %esi           # imm = 0xD800
               	leaq	0x8(%rsp), %rdx
               	callq	<addr>
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	jmp	<addr>
               	leaq	0x20(%rsp), %rdi
               	movl	$0xdc00, %esi           # imm = 0xDC00
               	leaq	0x8(%rsp), %rdx
               	callq	<addr>
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	jmp	<addr>
               	leaq	0x10(%rsp), %rdi
               	leaq	<rip>, %rsi
               	movl	$0x1, %edx
               	leaq	0x8(%rsp), %rcx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	cmpl	$0x0, 0x10(%rsp)
               	je	<addr>
               	movl	$0xc, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	leaq	0x18(%rsp), %rdi
               	leaq	<rip>, %rsi
               	movl	$0x1, %edx
               	leaq	0x8(%rsp), %rcx
               	callq	<addr>
               	cmpq	$0x1, %rax
               	jne	<addr>
               	movl	0x18(%rsp), %eax
               	cmpl	$0x7a, %eax
               	je	<addr>
               	movl	$0x1f, %eax
               	jmp	<addr>
               	leaq	0x30(%rsp), %rdi
               	movl	$0x71, %esi
               	leaq	0x8(%rsp), %rdx
               	callq	<addr>
               	cmpq	$0x1, %rax
               	jne	<addr>
               	leaq	0x30(%rsp), %rdi
               	movsbq	0x30(%rsp), %rax
               	cmpl	$0x71, %eax
               	je	<addr>
               	movl	$0x20, %eax
               	jmp	<addr>
               	movl	$0x72, %esi
               	leaq	0x8(%rsp), %rdx
               	callq	<addr>
               	cmpq	$0x1, %rax
               	jne	<addr>
               	movsbq	0x30(%rsp), %rax
               	cmpl	$0x72, %eax
               	je	<addr>
               	movl	$0x21, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	$0x1e, %edi
               	callq	<addr>
               	ud2
