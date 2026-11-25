
locale_objects_and_the_l_functions.x64:	file format elf64-x86-64

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

<main>:
               	subq	$0xb0, %rsp
               	pushq	%rbx
               	movl	$0x1fbf, %edi           # imm = 0x1FBF
               	leaq	<rip>, %rsi
               	xorl	%edx, %edx
               	callq	<addr>
               	movq	%rax, %rbx
               	testq	%rbx, %rbx
               	je	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r10
               	movq	%r10, 0x28(%rsp)
               	testq	%r10, %r10
               	jne	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	addq	$0xb0, %rsp
               	retq
               	movq	0x28(%rsp), %rdi
               	callq	<addr>
               	movq	%rax, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	%rcx, 0x10(%rsp)
               	xorl	%edi, %edi
               	callq	<addr>
               	movq	0x10(%rsp), %rcx
               	cmpq	0x28(%rsp), %rax
               	jne	<addr>
               	movq	%rcx, %rdi
               	callq	<addr>
               	cmpq	0x28(%rsp), %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	addq	$0xb0, %rsp
               	retq
               	movq	%rbx, %rsi
               	movl	$0x37, %edi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rbx, %rsi
               	movl	$0x61, %edi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rbx, %rsi
               	movl	$0x9, %edi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rbx, %rsi
               	movl	$0xa, %edi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xa, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	0x78(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movups	%xmm14, 0x20(%rax)
               	movq	$0x0, 0x30(%rax)
               	movl	$0x46, 0x8c(%rsp)
               	movl	$0x1, 0x84(%rsp)
               	movq	%rbx, %rdx
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jge	<addr>
               	movq	%rbx, %rcx
               	leaq	0x38(%rsp), %rdi
               	leaq	<rip>, %rsi
               	movl	$0x20, %edx
               	callq	<addr>
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0x14, %eax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbx
               	addq	$0xb0, %rsp
               	retq
               	movl	$0x3, %edi
               	leaq	<rip>, %rsi
               	movq	0x28(%rsp), %rdx
               	callq	<addr>
               	movq	%rax, %rdi
               	testq	%rdi, %rdi
               	jne	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	addq	$0xb0, %rsp
               	retq
               	callq	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	addq	$0xb0, %rsp
               	retq
               	movq	%rbx, %rdx
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	%rbx, %rcx
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	movl	$0x2, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x15, %eax
               	jmp	<addr>
               	movq	%rbx, %r8
               	leaq	0x38(%rsp), %rdi
               	movl	$0x20, %esi
               	leaq	<rip>, %rdx
               	leaq	0x78(%rsp), %rcx
               	callq	<addr>
               	cmpq	$0xa, %rax
               	jne	<addr>
               	leaq	0x38(%rsp), %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x16, %eax
               	jmp	<addr>
               	movsd	<rip>, %xmm0
               	movq	%rbx, %rdx
               	leaq	0x38(%rsp), %rdi
               	movl	$0x20, %esi
               	leaq	<rip>, %rcx
               	movb	$0x1, %al
               	callq	<addr>
               	cmpq	$0x9, %rax
               	jne	<addr>
               	leaq	0x38(%rsp), %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x17, %eax
               	jmp	<addr>
               	movq	%rbx, %rdx
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jge	<addr>
               	movq	%rbx, %rcx
               	leaq	0x58(%rsp), %rdi
               	leaq	<rip>, %rsi
               	movl	$0x8, %edx
               	callq	<addr>
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x18, %eax
               	jmp	<addr>
               	movq	%rbx, %rdx
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	%rbx, %rcx
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	movl	$0x2, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x19, %eax
               	jmp	<addr>
               	movq	%rbx, %rsi
               	movl	$0xe, %edi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	cmpb	$0x0, (%rax)
               	jne	<addr>
               	movl	$0x1a, %eax
               	jmp	<addr>
               	movq	%rbx, %rsi
               	movl	$0x2, %edi
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1b, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movq	%rbx, %rsi
               	movl	$0x37, %edi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rbx, %rsi
               	movl	$0x23, %edi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rbx, %rsi
               	movl	$0x61, %edi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rbx, %rsi
               	movl	$0x20, %edi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xb, %eax
               	jmp	<addr>
               	movq	%rbx, %rsi
               	movl	$0x23, %edi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rbx, %rsi
               	movl	$0x20, %edi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rbx, %rsi
               	movl	$0x41, %edi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rbx, %rsi
               	movl	$0x66, %edi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xc, %eax
               	jmp	<addr>
               	movq	%rbx, %rsi
               	movl	$0x37, %edi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	%rbx, %rsi
               	movl	$0x61, %edi
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x41, %rax
               	jne	<addr>
               	movq	%rbx, %rsi
               	movl	$0x41, %edi
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x61, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	jmp	<addr>
               	movq	%rbx, %rsi
               	movl	$0x37, %edi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rbx, %rsi
               	movl	$0x61, %edi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rbx, %rsi
               	movl	$0x9, %edi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rbx, %rsi
               	movl	$0xa, %edi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rbx, %rsi
               	movl	$0x37, %edi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rbx, %rsi
               	movl	$0x23, %edi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xe, %eax
               	jmp	<addr>
               	movq	%rbx, %rsi
               	movl	$0x61, %edi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rbx, %rsi
               	movl	$0x20, %edi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rbx, %rsi
               	movl	$0x23, %edi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rbx, %rsi
               	movl	$0x20, %edi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rbx, %rsi
               	movl	$0x41, %edi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rbx, %rsi
               	movl	$0x66, %edi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xf, %eax
               	jmp	<addr>
               	movq	%rbx, %rsi
               	movl	$0x61, %edi
               	callq	<addr>
               	cmpl	$0x41, %eax
               	jne	<addr>
               	movq	%rbx, %rsi
               	movl	$0x41, %edi
               	callq	<addr>
               	cmpl	$0x61, %eax
               	je	<addr>
               	movl	$0x10, %eax
               	jmp	<addr>
               	movq	%rbx, %rsi
               	leaq	<rip>, %rdi
               	callq	<addr>
               	movq	%rax, %r10
               	movq	%r10, 0x20(%rsp)
               	movq	%rbx, %rsi
               	leaq	<rip>, %rdi
               	callq	<addr>
               	movq	%rax, %r10
               	movq	%r10, 0x18(%rsp)
               	cmpq	$0x0, 0x20(%rsp)
               	je	<addr>
               	movq	%rbx, %rdx
               	movl	$0x61, %edi
               	movq	0x20(%rsp), %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rbx, %rdx
               	movl	$0x37, %edi
               	movq	0x20(%rsp), %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	%rbx, %rdx
               	movl	$0x61, %edi
               	movq	0x18(%rsp), %rsi
               	callq	<addr>
               	cmpl	$0x41, %eax
               	je	<addr>
               	movl	$0x11, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
