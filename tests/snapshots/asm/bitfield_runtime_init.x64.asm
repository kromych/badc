
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
               	andq	$0xf, %rdi
               	andq	$0xf, %rsi
               	movq	%rsi, %rax
               	shlq	$0x4, %rax
               	orq	%rdi, %rax
               	movq	%rdx, %rcx
               	andq	$0x1f, %rcx
               	shlq	$0x8, %rcx
               	orq	%rcx, %rax
               	movq	%rax, %rcx
               	andq	$0xf, %rcx
               	xorq	%rcx, %rdi
               	xorl	%ecx, %ecx
               	testl	%edi, %edi
               	jne	<addr>
               	movq	%rax, %rcx
               	sarq	$0x4, %rcx
               	andq	$0xf, %rcx
               	cmpl	%esi, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorl	%esi, %esi
               	testq	%rcx, %rcx
               	je	<addr>
               	sarq	$0x8, %rax
               	shlq	$0x3b, %rax
               	sarq	$0x3b, %rax
               	cmpl	%edx, %eax
               	sete	%al
               	movzbq	%al, %rax
               	movl	$0x1, %ecx
               	testq	%rax, %rax
               	movq	%rsi, %rax
               	cmovneq	%rcx, %rax
               	retq
               	movq	%rsi, %rax
               	jmp	<addr>

<build_mixed>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	-0x10(%rbp), %rax
               	movq	$0x0, (%rax)
               	movl	$0x0, 0x8(%rax)
               	movw	%di, -0x10(%rbp)
               	andq	$0x7, %rsi
               	movl	-0x10(%rbp), %eax
               	andq	$-0x70001, %rax         # imm = 0xFFF8FFFF
               	movq	%rsi, %r8
               	shlq	$0x10, %r8
               	orq	%r8, %rax
               	movl	%eax, -0x10(%rbp)
               	movq	%rdx, %r8
               	andq	$0x3ff, %r8             # imm = 0x3FF
               	andq	$-0x1ff80001, %rax      # imm = 0xE007FFFF
               	movq	%r8, %rdx
               	shlq	$0x13, %rdx
               	orq	%rdx, %rax
               	movl	%eax, -0x10(%rbp)
               	movq	%rcx, %r9
               	andq	$0x7ffff, %r9           # imm = 0x7FFFF
               	movl	%r9d, -0xc(%rbp)
               	movzwq	-0x10(%rbp), %rdx
               	andq	$0xffff, %rdi           # imm = 0xFFFF
               	cmpl	%edi, %edx
               	sete	%dil
               	movzbq	%dil, %rdi
               	xorl	%edx, %edx
               	testq	%rdi, %rdi
               	je	<addr>
               	movq	%rax, %rdx
               	sarq	$0x10, %rdx
               	andq	$0x7, %rdx
               	cmpl	%esi, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	xorl	%esi, %esi
               	testq	%rdx, %rdx
               	je	<addr>
               	sarq	$0x13, %rax
               	andq	$0x3ff, %rax            # imm = 0x3FF
               	cmpl	%r8d, %eax
               	sete	%sil
               	movzbq	%sil, %rsi
               	xorl	%eax, %eax
               	testq	%rsi, %rsi
               	je	<addr>
               	andq	$0x7ffff, %rcx          # imm = 0x7FFFF
               	cmpl	%ecx, %r9d
               	sete	%cl
               	movzbq	%cl, %rcx
               	movl	$0x1, %edx
               	testq	%rcx, %rcx
               	cmovneq	%rdx, %rax
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
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	movl	$0xff, %edi
               	movl	$0x1f, %esi
               	movl	$0xf, %edx
               	movl	$0xfffffff, %ecx        # imm = 0xFFFFFFF
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	xorl	%edi, %edi
               	movq	$-0x10, %rdx
               	movq	%rdi, %rsi
               	movq	%rdi, %rcx
               	callq	<addr>
               	testl	%eax, %eax
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
               	testl	%eax, %eax
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
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x5, %eax
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
