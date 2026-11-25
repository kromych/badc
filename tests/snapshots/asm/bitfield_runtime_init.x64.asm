
bitfield_runtime_init.x64:	file format elf64-x86-64

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
               	movq	%rax, %r8
               	andq	$0xf, %r8
               	xorq	%rdi, %r8
               	xorl	%ecx, %ecx
               	testl	%r8d, %r8d
               	jne	<addr>
               	movq	%rax, %rdi
               	sarq	$0x4, %rdi
               	andq	$0xf, %rdi
               	cmpl	%esi, %edi
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	sarq	$0x8, %rax
               	shlq	$0x3b, %rax
               	sarq	$0x3b, %rax
               	cmpl	%edx, %eax
               	sete	%al
               	movzbq	%al, %rax
               	movl	$0x1, %edx
               	testq	%rax, %rax
               	movq	%rcx, %rax
               	cmovneq	%rdx, %rax
               	retq
               	movq	%rcx, %rax
               	jmp	<addr>
               	movq	%rcx, %rsi
               	jmp	<addr>

<build_mixed>:
               	andq	$0xffff, %rdi           # imm = 0xFFFF
               	andq	$0x7, %rsi
               	movq	%rsi, %rax
               	shlq	$0x10, %rax
               	orq	%rdi, %rax
               	andq	$0x3ff, %rdx            # imm = 0x3FF
               	movq	%rdx, %rcx
               	shlq	$0x13, %rcx
               	orq	%rcx, %rax
               	movq	%rax, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	cmpl	%edi, %ecx
               	sete	%dil
               	movzbq	%dil, %rdi
               	xorl	%ecx, %ecx
               	testq	%rdi, %rdi
               	je	<addr>
               	movq	%rax, %rdi
               	sarq	$0x10, %rdi
               	andq	$0x7, %rdi
               	cmpl	%esi, %edi
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	sarq	$0x13, %rax
               	cmpl	%edx, %eax
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorl	%eax, %eax
               	movl	$0x1, %edx
               	testq	%rcx, %rcx
               	cmoveq	%rax, %rdx
               	movl	$0x1, %ecx
               	testq	%rdx, %rdx
               	cmovneq	%rcx, %rax
               	retq
               	movq	%rcx, %rsi
               	jmp	<addr>

<main>:
               	pushq	%rax
               	movl	$0x5, %edi
               	movl	$0xa, %esi
               	movq	$-0x3, %rdx
               	movl	$0x12345, %ecx          # imm = 0x12345
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x1, %eax
               	popq	%r11
               	retq
               	movl	$0xff, %edi
               	movl	$0x1f, %esi
               	movl	$0xf, %edx
               	movl	$0xfffffff, %ecx        # imm = 0xFFFFFFF
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x2, %eax
               	popq	%r11
               	retq
               	xorl	%edi, %edi
               	movq	$-0x10, %rdx
               	movq	%rdi, %rsi
               	movq	%rdi, %rcx
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x3, %eax
               	popq	%r11
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
               	popq	%r11
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
               	popq	%r11
               	retq
               	xorl	%eax, %eax
               	popq	%r11
               	retq
