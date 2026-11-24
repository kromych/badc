
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
               	orq	%rax, %rcx
               	movq	%rcx, %rax
               	andq	$0xf, %rax
               	xorq	%rax, %rdi
               	xorl	%eax, %eax
               	testl	%edi, %edi
               	jne	<addr>
               	movq	%rcx, %rax
               	sarq	$0x4, %rax
               	andq	$0xf, %rax
               	cmpl	%esi, %eax
               	sete	%al
               	movzbq	%al, %rax
               	xorl	%esi, %esi
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rcx, %rax
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
               	movq	%rdi, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movq	%rsi, %r8
               	andq	$0x7, %r8
               	movq	%r8, %rsi
               	shlq	$0x10, %rsi
               	orq	%rax, %rsi
               	movq	%rdx, %rdi
               	andq	$0x3ff, %rdi            # imm = 0x3FF
               	shlq	$0x13, %rdi
               	orq	%rsi, %rdi
               	movq	%rcx, %r9
               	andq	$0x7ffff, %r9           # imm = 0x7FFFF
               	movq	%rdi, %rsi
               	andq	$0xffff, %rsi           # imm = 0xFFFF
               	cmpl	%eax, %esi
               	sete	%al
               	movzbq	%al, %rax
               	xorl	%esi, %esi
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rdi, %rax
               	sarq	$0x10, %rax
               	andq	$0x7, %rax
               	cmpl	%r8d, %eax
               	sete	%sil
               	movzbq	%sil, %rsi
               	xorl	%eax, %eax
               	testq	%rsi, %rsi
               	je	<addr>
               	movq	%rdi, %rsi
               	sarq	$0x13, %rsi
               	andq	$0x3ff, %rdx            # imm = 0x3FF
               	cmpl	%edx, %esi
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	%rcx, %rax
               	andq	$0x7ffff, %rax          # imm = 0x7FFFF
               	cmpl	%eax, %r9d
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
