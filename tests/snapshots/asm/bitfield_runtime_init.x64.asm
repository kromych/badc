
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
               	andq	$0xffff, %rdi           # imm = 0xFFFF
               	movq	%rsi, %rax
               	andq	$0x7, %rax
               	movq	%rax, %rsi
               	shlq	$0x10, %rsi
               	orq	%rdi, %rsi
               	movq	%rdx, %r8
               	andq	$0x3ff, %r8             # imm = 0x3FF
               	shlq	$0x13, %r8
               	orq	%r8, %rsi
               	movq	%rcx, %r8
               	andq	$0x7ffff, %r8           # imm = 0x7FFFF
               	movq	%rsi, %r9
               	andq	$0xffff, %r9            # imm = 0xFFFF
               	cmpl	%edi, %r9d
               	sete	%r9b
               	movzbq	%r9b, %r9
               	xorl	%edi, %edi
               	testq	%r9, %r9
               	je	<addr>
               	movq	%rsi, %rdi
               	sarq	$0x10, %rdi
               	andq	$0x7, %rdi
               	cmpl	%eax, %edi
               	sete	%dil
               	movzbq	%dil, %rdi
               	xorl	%eax, %eax
               	testq	%rdi, %rdi
               	je	<addr>
               	sarq	$0x13, %rsi
               	andq	$0x3ff, %rdx            # imm = 0x3FF
               	cmpl	%edx, %esi
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	%rcx, %rax
               	andq	$0x7ffff, %rax          # imm = 0x7FFFF
               	cmpl	%eax, %r8d
               	sete	%al
               	movzbq	%al, %rax
               	xorl	%ecx, %ecx
               	movl	$0x1, %edx
               	testq	%rax, %rax
               	movq	%rcx, %rax
               	cmovneq	%rdx, %rax
               	retq
               	movq	%rax, %rdx
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
