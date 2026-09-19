
bitfield_runtime_init.x64:	file format elf64-x86-64

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

<build_packed>:
               	movq	%rdi, %rax
               	andq	$0xf, %rax
               	movq	%rsi, %rdi
               	andq	$0xf, %rdi
               	movq	%rdi, %rsi
               	shlq	$0x4, %rsi
               	orq	%rax, %rsi
               	movq	%rdx, %r8
               	andq	$0x1f, %r8
               	andq	$-0x1f01, %rsi          # imm = 0xE0FF
               	shlq	$0x8, %r8
               	orq	%r8, %rsi
               	movq	%rcx, %r8
               	andq	$0xfffff, %r8           # imm = 0xFFFFF
               	movq	%rsi, %rcx
               	andq	$0xf, %rcx
               	xorq	%rcx, %rax
               	xorl	%ecx, %ecx
               	testl	%eax, %eax
               	jne	<addr>
               	movl	%esi, %eax
               	sarq	$0x4, %rax
               	andq	$0xf, %rax
               	xorq	%rdi, %rax
               	testl	%eax, %eax
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorl	%eax, %eax
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	%esi, %ecx
               	sarq	$0x8, %rcx
               	andq	$0x1f, %rcx
               	shlq	$0x3b, %rcx
               	sarq	$0x3b, %rcx
               	cmpl	%edx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	%r8, %rax
               	xorq	%r8, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	retq
               	movq	%rax, %rcx
               	jmp	<addr>

<build_mixed>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	pushq	%r12
               	pushq	%rbx
               	leaq	-0x10(%rbp), %rax
               	movq	$0x0, (%rax)
               	movl	$0x0, 0x8(%rax)
               	movw	%di, (%rax)
               	andq	$0x7, %rsi
               	movl	(%rax), %r9d
               	andq	$-0x70001, %r9          # imm = 0xFFF8FFFF
               	movq	%rsi, %rbx
               	shlq	$0x10, %rbx
               	orq	%rbx, %r9
               	movl	%r9d, (%rax)
               	leaq	-0x10(%rbp), %r12
               	movq	%rdx, %rbx
               	andq	$0x3ff, %rbx            # imm = 0x3FF
               	movq	%r9, %rax
               	andq	$-0x1ff80001, %rax      # imm = 0xE007FFFF
               	movq	%rbx, %rdx
               	shlq	$0x13, %rdx
               	orq	%rdx, %rax
               	movl	%eax, (%r12)
               	leaq	-0x10(%rbp), %rdx
               	movq	%rcx, %r9
               	andq	$0x7ffff, %r9           # imm = 0x7FFFF
               	movl	%r9d, 0x4(%rdx)
               	leaq	-0x10(%rbp), %rdx
               	movl	%r8d, 0x8(%rdx)
               	leaq	-0x10(%rbp), %rdx
               	movzwq	(%rdx), %rdx
               	andq	$0xffff, %rdi           # imm = 0xFFFF
               	cmpl	%edi, %edx
               	sete	%dil
               	movzbq	%dil, %rdi
               	xorl	%edx, %edx
               	testq	%rdi, %rdi
               	je	<addr>
               	movl	%eax, %edx
               	sarq	$0x10, %rdx
               	andq	$0x7, %rdx
               	xorq	%rsi, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	xorl	%esi, %esi
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	%eax, %eax
               	sarq	$0x13, %rax
               	andq	$0x3ff, %rax            # imm = 0x3FF
               	xorq	%rbx, %rax
               	testl	%eax, %eax
               	sete	%sil
               	movzbq	%sil, %rsi
               	xorl	%eax, %eax
               	testq	%rsi, %rsi
               	je	<addr>
               	andq	$0x7ffff, %rcx          # imm = 0x7FFFF
               	xorq	%r9, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	cmpl	%r8d, %r8d
               	sete	%al
               	movzbq	%al, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movq	%rax, %rcx
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x5, %edi
               	movl	$0xa, %esi
               	movq	$-0x3, %rdx
               	movl	$0x12345, %ecx          # imm = 0x12345
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	movl	$0xff, %edi
               	movl	$0x1f, %esi
               	movl	$0xf, %edx
               	movl	$0xfffffff, %ecx        # imm = 0xFFFFFFF
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	xorl	%edi, %edi
               	movq	$-0x10, %rdx
               	movq	%rdi, %rsi
               	movq	%rdi, %rcx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	movl	$0x1234, %edi           # imm = 0x1234
               	movl	$0x6, %esi
               	movl	$0x1f4, %edx            # imm = 0x1F4
               	movl	$0x186a0, %ecx          # imm = 0x186A0
               	movq	$-0x4d, %r8
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
               	movl	$0xffff, %edi           # imm = 0xFFFF
               	movl	$0x7, %esi
               	movl	$0x3ff, %edx            # imm = 0x3FF
               	movl	$0x7ffff, %ecx          # imm = 0x7FFFF
               	movl	$0x7fffffff, %r8d       # imm = 0x7FFFFFFF
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x5, %eax
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
